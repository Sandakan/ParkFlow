import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lots_notifier.dart';
import 'package:parkflow/presentation/widgets/admin/lot_card.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class AdminParkingLotsScreen extends ConsumerWidget {
  const AdminParkingLotsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(parkingLotsProvider);

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
                        .read(parkingLotsProvider.notifier)
                        .updateSearchQuery(value),
                    decoration: InputDecoration(
                      hintText: context.l10n.searchLotHint,
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
                  child: RefreshIndicator(
                    onRefresh: () => ref
                        .read(parkingLotsProvider.notifier)
                        .fetchLots(query: state.searchQuery),
                    child: state.isLoading && state.lots.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : state.error != null
                        ? _ErrorState(error: state.error!)
                        : state.lots.isEmpty
                        ? const _EmptyState()
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ).copyWith(bottom: 80),
                            itemCount: state.lots.length,
                            itemBuilder: (context, index) {
                              final lot = state.lots[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: LotCard(
                                  lot: lot,
                                  onTap: () {
                                    AdminParkingLotDetailsRoute(
                                      lot.id,
                                    ).go(context);
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          const AdminCreateParkingLotRoute().go(context);
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
        icon: const Icon(Icons.add),
        label: Text(
          context.l10n.createNewLot,
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
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_parking_outlined,
                size: 80,
                color: AppColors.outlineVariant,
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.noLotsFound,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  const _ErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.errorLoadingLots,
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
        ),
      ],
    );
  }
}
