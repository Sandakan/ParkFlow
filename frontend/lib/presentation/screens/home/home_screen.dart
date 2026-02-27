import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

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
            tooltip: context.l10n.logoutTooltip,
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
                padding: const EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 800
                      ? 6
                      : MediaQuery.of(context).size.width > 600
                      ? 4
                      : 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: parkingState.slots.length,
                itemBuilder: (context, index) {
                  final slot = parkingState.slots[index];
                  return Card(
                    color: slot.isOccupied
                        ? AppColors.occupiedBackground
                        : AppColors.availableBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide(
                        color: slot.isOccupied
                            ? AppColors.occupiedBorder
                            : AppColors.availableBorder,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8.0,
                      children: [
                        Icon(
                          slot.isOccupied
                              ? Icons.directions_car
                              : Icons.local_parking,
                          size: 36.0,
                          color: slot.isOccupied
                              ? AppColors.occupiedText
                              : AppColors.availableText,
                        ),
                        Text(
                          slot.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: slot.isOccupied
                                    ? AppColors.occupiedTextDark
                                    : AppColors.availableTextDark,
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
