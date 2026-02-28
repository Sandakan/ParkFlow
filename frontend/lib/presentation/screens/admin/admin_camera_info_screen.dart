import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/widgets/camera/camera_webrtc_player.dart';

import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/notifiers/cameras/camera_info_notifier.dart';
import 'package:parkflow/presentation/widgets/camera/spot_picker_canvas.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';

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
                    '${state.camera?.lotName ?? 'Unknown Lot'} > ${state.camera?.name ?? 'Loading...'}',
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
              child: const Row(
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    color: Colors.white,
                    size: 12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
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
                    const Text(
                      'Parking Slots',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (state.interactionMode ==
                        InteractionMode.inspection) ...[
                      IconButton(
                        icon: const Icon(Icons.add_box_outlined),
                        tooltip: 'Add Slot',
                        onPressed: () => notifier.setInteractionMode(
                          InteractionMode.drawing,
                        ),
                      ),
                    ] else
                      IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Cancel Drawing',
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
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Tap 4 points on the video to define the parking slot corners.',
                    style: TextStyle(color: AppColors.primary, fontSize: 13),
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text(
                      'Show AI Detections',
                      style: TextStyle(fontSize: 14),
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
                    'No slots defined yet.',
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
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Saving new slot...',
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
            slot.isOccupied ? 'Occupied' : 'Vacant',
            style: TextStyle(
              color: slot.isOccupied ? Colors.red : Colors.green,
              fontSize: 12,
            ),
          ),
          Text(
            'Type: ${slot.slotType?.toUpperCase() ?? 'GENERAL'}',
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
        title: const Text('Delete Slot'),
        content: Text('Are you sure you want to delete ${slot.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              notifier.deleteSlot(slot.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _promptSlotName(CameraInfo notifier) {
    final controller = TextEditingController();
    String tempType = 'general';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('New Parking Slot'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Slot Identifier',
                      hintText: 'e.g. A-15',
                      border: OutlineInputBorder(),
                    ),
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: tempType,
                    decoration: const InputDecoration(
                      labelText: 'Slot Type',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'general',
                        child: Text('General'),
                      ),
                      DropdownMenuItem(
                        value: 'disabled',
                        child: Text('Disabled'),
                      ),
                      DropdownMenuItem(value: 'ev', child: Text('EV Charging')),
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
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = controller.text.trim();
                    if (name.isNotEmpty) {
                      Navigator.of(context).pop();
                      notifier.setSelectedSlotType(tempType);
                      await notifier.saveSlot(name);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Slot $name saved')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Slot'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
