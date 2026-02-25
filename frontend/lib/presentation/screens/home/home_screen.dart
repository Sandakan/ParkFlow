import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/routes/parts/video_routes.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkingState = ref.watch(parkingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.liveDashboard),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => const VideoFeedRoute().push(context),
        icon: const Icon(Icons.videocam),
        label: Text(context.l10n.liveFeed),
      ),
      body: parkingState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : parkingState.error != null
          ? Center(
              child: Text(
                AppException.getLocalizedErrorMessage(
                  parkingState.error,
                  AppLocalizations.of(context),
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(parkingProvider);
              },
              child: GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 800
                      ? 6
                      : MediaQuery.of(context).size.width > 600
                      ? 4
                      : 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1.2,
                ),
                itemCount: parkingState.slots.length,
                itemBuilder: (context, index) {
                  final slot = parkingState.slots[index];
                  return Card(
                    color: slot.isOccupied
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      side: BorderSide(
                        color: slot.isOccupied
                            ? Colors.red.shade300
                            : Colors.green.shade300,
                        width: 1.5.w,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8.h,
                      children: [
                        Icon(
                          slot.isOccupied
                              ? Icons.directions_car
                              : Icons.local_parking,
                          size: 36.sp,
                          color: slot.isOccupied
                              ? Colors.red.shade700
                              : Colors.green.shade700,
                        ),
                        Text(
                          slot.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: slot.isOccupied
                                    ? Colors.red.shade900
                                    : Colors.green.shade900,
                              ),
                        ),
                        Text(
                          slot.isOccupied
                              ? context.l10n.occupied
                              : context.l10n.available,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
