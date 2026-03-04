import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/widgets/camera/camera_webrtc_player.dart';

import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/notifiers/cameras/camera_info_notifier.dart';
import 'package:parkflow/presentation/widgets/camera/spot_picker_canvas.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/repositories/entities/parking/update_camera_request.dart';
import 'package:go_router/go_router.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminCameraInfoScreen extends ConsumerStatefulWidget {
  final String cameraId;

  const AdminCameraInfoScreen({required this.cameraId, super.key});

  @override
  ConsumerState<AdminCameraInfoScreen> createState() =>
      _AdminCameraInfoScreenState();
}

class _AdminCameraInfoScreenState extends ConsumerState<AdminCameraInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cameraInfoProvider(widget.cameraId));
    final notifier = ref.read(cameraInfoProvider(widget.cameraId).notifier);

    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Background Video Layer
          Positioned.fill(child: CameraWebrtcPlayer(cameraId: widget.cameraId)),

          // 2. Interaction Layer
          Positioned.fill(
            child: SpotPickerCanvas(
              mode: state.interactionMode,
              normalizedCurrentPoints: state.currentDrawingPoints,
              slots: state.slots,
              showAiDetections: state.showAiDetections,
              aiDetections: state.aiDetections,
              aiSlotHits: state.aiSlotHits,
              onTap: (normalizedPoint) {
                notifier.addDrawingPoint(normalizedPoint);
                if (state.currentDrawingPoints.length == 3) {
                  // 4th point just added via onTap, prompt name
                  _promptSlotName(notifier);
                }
              },
            ),
          ),

          // 3. Header Layer
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context, state, notifier),
          ),

          // 4. Sidebar or Bottom Sheet Layer
          if (isWide)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: 80,
              right: state.isSidebarCollapsed ? -260 : 0,
              bottom: 0,
              width: 300,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _buildSidebar(context, state, notifier),
                  ),
                ],
              ),
            )
          else
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.1,
              maxChildSize: 0.9,
              snapSizes: [0.1, 0.3, 0.5, 0.7, 0.9],
              snap: true,
              builder: (context, scrollController) {
                return _buildSidebar(
                  context,
                  state,
                  notifier,
                  isBottomSheet: true,
                  scrollController: scrollController,
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    CameraInfoState state,
    CameraInfo notifier,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.camera?.lotName ?? context.l10n.unknownLot} > ${state.camera?.name ?? context.l10n.loading}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Live Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.fiber_manual_record,
                    color: Colors.white,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    context.l10n.liveBadge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.white),
              tooltip: context.l10n.editCameraTooltip,
              onPressed: () => _showEditCameraDialog(context, state, notifier),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.white),
              tooltip: context.l10n.deleteCameraTooltip,
              onPressed: () => _confirmDeleteCamera(context, notifier),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: Icon(
                state.isSidebarCollapsed ? Icons.menu_open : Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => notifier.toggleSidebar(),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditCameraDialog(
    BuildContext context,
    CameraInfoState state,
    CameraInfo notifier,
  ) {
    if (state.camera == null) return;

    final form = fb.group({
      'name': FormControl<String>(
        value: state.camera!.name,
        validators: [Validators.required],
      ),
      'rtspUrl': FormControl<String>(
        value: state.camera!.rtspUrl,
        validators: [Validators.required],
      ),
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.editCameraDialogTitle),
        content: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReactiveTextField<String>(
                formControlName: 'name',
                decoration: InputDecoration(
                  labelText: context.l10n.cameraNameLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ReactiveTextField<String>(
                formControlName: 'rtspUrl',
                decoration: InputDecoration(
                  labelText: context.l10n.rtspUrlLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(context.l10n.cancelButton),
          ),
          ElevatedButton(
            onPressed: () async {
              if (form.valid) {
                final request = UpdateCameraRequest(
                  name: form.control('name').value as String,
                  rtspUrl: form.control('rtspUrl').value as String,
                );
                try {
                  await notifier.updateCamera(request);
                  if (context.mounted) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.cameraUpdatedSuccess),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppException.getLocalizedErrorMessage(
                            e,
                            context.l10n,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(context.l10n.saveChangesButton),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteCamera(BuildContext context, CameraInfo notifier) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.deleteCameraConfirmTitle),
        content: Text(context.l10n.deleteCameraConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(),
            child: Text(context.l10n.cancelButton),
          ),
          TextButton(
            onPressed: () async {
              try {
                ctx.pop();
                await notifier.deleteCamera();

                if (context.mounted) {
                  context.pop(); // Go back to cameras list
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.l10n.cameraDeletedSuccess)),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppException.getLocalizedErrorMessage(e, context.l10n),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.l10n.deleteButton),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(
    BuildContext context,
    CameraInfoState state,
    CameraInfo notifier, {
    bool isBottomSheet = false,
    ScrollController? scrollController,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: isBottomSheet
            ? const BorderRadius.vertical(top: Radius.circular(20))
            : const BorderRadius.horizontal(left: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10),
        ],
      ),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: isBottomSheet,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            if (isBottomSheet)
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 4),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.parkingSlotsTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (state.interactionMode ==
                        InteractionMode.inspection) ...[
                      IconButton(
                        icon: const Icon(Icons.add_box_outlined),
                        tooltip: context.l10n.addSlotTooltip,
                        onPressed: () => notifier.setInteractionMode(
                          InteractionMode.drawing,
                        ),
                      ),
                    ] else
                      IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: context.l10n.cancelDrawingTooltip,
                        onPressed: () {
                          notifier.resetDrawing();
                          notifier.setInteractionMode(
                            InteractionMode.inspection,
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            if (state.interactionMode == InteractionMode.drawing)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    context.l10n.tapPointsInstruction,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      context.l10n.showAiDetectionsLabel,
                      style: const TextStyle(fontSize: 14),
                    ),
                    value: state.showAiDetections,
                    onChanged: (val) => notifier.toggleAiDetections(),
                    activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
                    activeThumbColor: AppColors.primary,
                  ),
                  const Divider(),
                ],
              ),
            ),
            if (state.isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.slots.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    context.l10n.noSlotsDefinedMessage,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final slot = state.slots[index];
                  return _buildSlotItem(context, slot, notifier);
                }, childCount: state.slots.length),
              ),
            if (state.isSavingSlot)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        context.l10n.savingNewSlotMessage,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotItem(
    BuildContext context,
    ParkingSlotModel slot,
    CameraInfo notifier,
  ) {
    return ListTile(
      leading: Icon(
        Icons.local_parking,
        color: slot.isOccupied ? Colors.red : AppColors.primary,
      ),
      title: Text(slot.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slot.isOccupied ? context.l10n.occupied : context.l10n.vacantStatus,
            style: TextStyle(
              color: slot.isOccupied ? Colors.red : Colors.green,
              fontSize: 12,
            ),
          ),
          Text(
            '${context.l10n.slotTypePrefix}: ${slot.slotType?.toUpperCase() ?? context.l10n.slotTypeGeneral.toUpperCase()}',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 11),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: () => _confirmDelete(context, slot, notifier),
      ),
      onTap: () {
        // Handle slot click (e.g. highlight it on the canvas)
      },
    );
  }

  void _confirmDelete(
    BuildContext context,
    ParkingSlotModel slot,
    CameraInfo notifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteSlotConfirmTitle),
        content: Text(context.l10n.deleteSlotConfirmMessage(slot.name)),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(context.l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              notifier.deleteSlot(slot.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.l10n.deleteButton),
          ),
        ],
      ),
    );
  }

  void _promptSlotName(CameraInfo notifier) {
    final controller = TextEditingController();
    final rowController = TextEditingController(text: '0');
    final colController = TextEditingController(text: '0');
    String tempType = 'general';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(context.l10n.newParkingSlotTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: context.l10n.slotIdentifierLabel,
                      hintText: context.l10n.slotIdentifierHint,
                      border: const OutlineInputBorder(),
                    ),
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: rowController,
                          decoration: const InputDecoration(
                            labelText: 'Logical Row',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: colController,
                          decoration: const InputDecoration(
                            labelText: 'Logical Column',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: tempType,
                    decoration: InputDecoration(
                      labelText: context.l10n.slotTypeLabel,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'general',
                        child: Text(context.l10n.slotTypeGeneral),
                      ),
                      DropdownMenuItem(
                        value: 'disabled',
                        child: Text(context.l10n.slotTypeDisabled),
                      ),
                      DropdownMenuItem(
                        value: 'ev',
                        child: Text(context.l10n.slotTypeEv),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => tempType = val);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    notifier.resetDrawing();
                    notifier.setInteractionMode(InteractionMode.inspection);
                  },
                  child: Text(context.l10n.cancelButton),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final nameStr = controller.text.trim();
                    if (nameStr.isNotEmpty) {
                      Navigator.of(context).pop();
                      notifier.setSelectedSlotType(tempType);
                      final row = int.tryParse(rowController.text) ?? 0;
                      final col = int.tryParse(colController.text) ?? 0;
                      await notifier.saveSlot(
                        nameStr,
                        logicalRow: row,
                        logicalCol: col,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context.l10n.slotSavedSuccess(nameStr),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(context.l10n.saveSlotButton),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
