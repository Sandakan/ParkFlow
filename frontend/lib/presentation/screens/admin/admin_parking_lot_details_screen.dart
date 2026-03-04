import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/widgets/admin/parking_lot_layout_sheet.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lot_layout_notifier.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class AdminParkingLotDetailsScreen extends ConsumerWidget {
  final String lotId;

  const AdminParkingLotDetailsScreen({super.key, required this.lotId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutState = ref.watch(parkingLotLayoutProvider(lotId));

    return Scaffold(
      appBar: AppBar(
        title: Text(layoutState.lot?.name ?? context.l10n.parkingLotsTitle),
      ),
      body: layoutState.lot == null && layoutState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: ParkingLotLayoutSheet(
                lot:
                    layoutState.lot ??
                    ParkingLotModel(
                      id: lotId,
                      name: '',
                      isOpen: true,
                      camerasCount: 0,
                      totalSlots: 0,
                      occupancy: 0,
                      revenueToday: 0,
                      address: '',
                    ),
                isSheet: false,
              ),
            ),
    );
  }
}
