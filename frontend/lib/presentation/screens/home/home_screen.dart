import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_debounce/easy_debounce.dart';

import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';

import 'package:parkflow/presentation/notifiers/parking/home_search_controller.dart';
import 'package:parkflow/presentation/widgets/parking/parking_lot_card.dart';
import 'package:parkflow/presentation/widgets/parking/parking_suggestion_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkingState = ref.watch(parkingProvider);

    final searchController = ref.watch(homeSearchControllerProvider);

    ref.listen(parkingProvider.select((s) => s.searchQuery), (prev, next) {
      if (next != searchController.text) {
        searchController.text = next ?? '';
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          context.l10n.explore,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
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
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(parkingProvider);
        },
        child: CustomScrollView(
          slivers: [
            _buildSearchBar(context, searchController, ref),
            if (parkingState.isLoading && parkingState.lots.isNotEmpty)
              const SliverToBoxAdapter(
                child: LinearProgressIndicator(
                  minHeight: 2,
                  backgroundColor: AppColors.white,
                  color: AppColors.primary,
                ),
              ),
            if (parkingState.isLoading && parkingState.lots.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (parkingState.lots.isEmpty && !parkingState.isLoading)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text(context.l10n.noLotsNearby)),
              )
            else ...[
              if (parkingState.lots.isNotEmpty)
                SliverToBoxAdapter(
                  child: _buildNearbyLots(context, ref, parkingState),
                ),
              if (parkingState.suggestions.isNotEmpty)
                SliverToBoxAdapter(
                  child: _buildSuggestions(context, parkingState),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    TextEditingController controller,
    WidgetRef ref,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: TextField(
          controller: controller,
          onChanged: (value) {
            EasyDebounce.debounce(
              'search-debouncer',
              const Duration(milliseconds: 500),
              () {
                final query = value.trim();
                ref
                    .read(parkingProvider.notifier)
                    .fetchLots(query: query.isEmpty ? null : query);
              },
            );
          },
          decoration: InputDecoration(
            hintText: context.l10n.searchLotHint,
            hintStyle: const TextStyle(fontSize: 15),
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.surfaceVariant.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildNearbyLots(
    BuildContext context,
    WidgetRef ref,
    ParkingState state,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  context.l10n.nearbyLots,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 180,
            child: PageView.builder(
              itemCount: state.lots.length,
              controller: PageController(viewportFraction: 0.9),
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                final lot = state.lots[index];
                final isSelected = state.lot?.id == lot.id;
                return ParkingLotCard(lot: lot, isSelected: isSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context, ParkingState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                context.l10n.topRecommended,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: Text(context.l10n.seeAll)),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.suggestions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final s = state.suggestions[index];
              return ParkingSuggestionCard(suggestion: s, onTap: () {});
            },
          ),
        ],
      ),
    );
  }
}
