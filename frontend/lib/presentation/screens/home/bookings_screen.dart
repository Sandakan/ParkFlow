import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/notifiers/parking/reservation_notifier.dart';
import 'package:parkflow/presentation/widgets/parking/reservation_card.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationsState = ref.watch(reservationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.bookings,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(reservationNotifierProvider.future),
            child: reservationsState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (reservations) {
                if (reservations.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Center(
                        child: Text(
                          context.l10n.noBookingsFound,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                final now = DateTime.now();
                final allUpcoming =
                    reservations.where((r) => r.endTime.isAfter(now)).toList()
                      ..sort((a, b) => a.startTime.compareTo(b.startTime));

                final topUpcoming = allUpcoming.take(3).toList();
                final restUpcoming = allUpcoming.skip(3).toList();

                final past = reservations
                    .where(
                      (r) =>
                          r.endTime.isBefore(now) ||
                          r.endTime.isAtSameMomentAs(now),
                    )
                    .toList();

                final history = [...restUpcoming, ...past]
                  ..sort((a, b) => b.startTime.compareTo(a.startTime));

                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (topUpcoming.isNotEmpty) ...[
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 24,
                          bottom: 12,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            context.l10n.upcomingBookings,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: topUpcoming.length,
                            itemBuilder: (context, index) {
                              return ReservationCard(
                                reservation: topUpcoming[index],
                                isHorizontal: true,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                    if (history.isNotEmpty) ...[
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 32,
                          bottom: 16,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            context.l10n.previousBookings,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return ReservationCard(
                              reservation: history[index],
                              isHorizontal: false,
                            );
                          }, childCount: history.length),
                        ),
                      ),
                    ] else if (topUpcoming.isEmpty) ...[
                      SliverToBoxAdapter(
                        child: Center(
                          child: Text(context.l10n.noBookingsFound),
                        ),
                      ),
                    ],
                    // Extra spacing at bottom
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
