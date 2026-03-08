import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/notifiers/parking/reservation_notifier.dart';
import 'package:parkflow/presentation/widgets/parking/ongoing_booking_card.dart';
import 'package:parkflow/presentation/widgets/parking/reservation_card.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/models/parking/reservation_model.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationsState = ref.watch(reservationNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
              error: (err, stack) => ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Error: $err',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  ),
                ],
              ),
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

                final ongoing = reservations
                    .where(
                      (r) =>
                          r.detailedStatus == ReservationStatus.ongoing ||
                          r.detailedStatus == ReservationStatus.overstay,
                    )
                    .firstOrNull;

                final upcomingSorted =
                    reservations
                        .where(
                          (r) => r.detailedStatus == ReservationStatus.upcoming,
                        )
                        .toList()
                      ..sort((a, b) => a.startTime.compareTo(b.startTime));
                final topUpcoming = upcomingSorted.take(3).toList();

                final previousAndOther =
                    reservations
                        .where(
                          (r) =>
                              r.id != ongoing?.id &&
                              !topUpcoming.any((t) => t.id == r.id),
                        )
                        .toList()
                      ..sort((a, b) => b.startTime.compareTo(a.startTime));

                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (ongoing != null) ...[
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 24,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: OngoingBookingCard(reservation: ongoing),
                        ),
                      ),
                    ],
                    if (topUpcoming.isNotEmpty) ...[
                      SliverPadding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: ongoing == null ? 24 : 8,
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
                          height: 200,
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
                    if (previousAndOther.isNotEmpty) ...[
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
                              reservation: previousAndOther[index],
                              isHorizontal: false,
                            );
                          }, childCount: previousAndOther.length),
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
