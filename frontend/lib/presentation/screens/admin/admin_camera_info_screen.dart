import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/widgets/camera/camera_webrtc_player.dart';

import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/notifiers/cameras/camera_info_notifier.dart';
import 'package:parkflow/presentation/widgets/camera/spot_picker_canvas.dart';

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
              currentPoints: state.currentDrawingPoints,
              showAiDetections: state.showAiDetections,
              onTap: (point) {
                notifier.addDrawingPoint(point);
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
                  // Toggle Button for Wide Screen
                  Positioned(
                    left: 0,
                    top: 20,
                    child: GestureDetector(
                      onTap: () => notifier.toggleSidebar(),
                      child: Container(
                        width: 32,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          state.isSidebarCollapsed
                              ? Icons.chevron_left
                              : Icons.chevron_right,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
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
            if (state.isSidebarCollapsed) ...[
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.menu_open, color: Colors.white),
                onPressed: () => notifier.toggleSidebar(),
              ),
            ],
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
                      if (!isBottomSheet)
                        IconButton(
                          icon: Icon(
                            state.isSidebarCollapsed
                                ? Icons.keyboard_arrow_right
                                : Icons.keyboard_arrow_left,
                          ),
                          tooltip: 'Collapse',
                          onPressed: () => notifier.toggleSidebar(),
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
            SliverList(
              delegate: SliverChildListDelegate([
                _buildSlotItem('Slot A1'),
                _buildSlotItem('Slot A2'),
                _buildSlotItem('Slot A3'),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotItem(String name) {
    return ListTile(
      leading: Icon(Icons.local_parking, color: AppColors.textSecondary),
      title: Text(name),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Handle slot click (e.g. highlight it on the canvas)
      },
    );
  }

  void _promptSlotName(CameraInfo notifier) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Parking Slot'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'e.g. A-15',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
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
                  await notifier.saveSlot(name);
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Slot $name saved')));
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
  }
}
