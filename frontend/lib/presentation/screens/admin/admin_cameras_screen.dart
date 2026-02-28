import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/notifiers/cameras/cameras_notifier.dart';
import 'package:parkflow/presentation/widgets/camera/camera_card.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class AdminCamerasScreen extends ConsumerWidget {
  const AdminCamerasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(camerasProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                // Search Bar Area
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) => ref
                        .read(camerasProvider.notifier)
                        .updateSearchQuery(value),
                    decoration: InputDecoration(
                      hintText: context.l10n.searchCameraHint,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.surfaceVariant.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                ),

                // Main List
                Expanded(
                  child: state.isLoading && state.cameras.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : state.error != null
                      ? _ErrorState(error: state.error!)
                      : state.filteredCameras.isEmpty
                      ? const _EmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.filteredCameras.length,
                          itemBuilder: (context, index) {
                            final camera = state.filteredCameras[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: CameraCard(
                                camera: camera,
                                onTap: () {
                                  AdminCameraInfoRoute(camera.id).push(context);
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          const AdminCreateCameraRoute().push(context);
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
        icon: const Icon(Icons.add),
        label: Text(
          context.l10n.createNewCamera,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.videocam_off_outlined,
            size: 80,
            color: AppColors.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.noCamerasFound,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  const _ErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 60),
            const SizedBox(height: 16),
            Text(
              context.l10n.errorLoadingCameras,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
