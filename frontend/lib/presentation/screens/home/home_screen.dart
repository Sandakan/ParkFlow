import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';

import 'package:parkflow/presentation/notifiers/parking/home_search_controller.dart';
import 'package:parkflow/presentation/widgets/parking/parking_lot_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  final PageController _pageController = PageController(viewportFraction: 0.85);
  bool _hasCenteredInitially = false;
  Map<String, BitmapDescriptor> _markerIcons = {};

  @override
  void initState() {
    super.initState();
    _loadAllMarkerIcons();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadAllMarkerIcons() async {
    final parkingState = ref.read(parkingProvider);
    final Map<String, BitmapDescriptor> icons = {};
    for (final lot in parkingState.lots) {
      icons[lot.id] = await _getMarkerIcon(lot);
    }
    if (mounted) {
      setState(() {
        _markerIcons = icons;
      });
    }
  }

  Future<void> _centerOnUser(ParkingState state) async {
    if (state.userPosition != null) {
      final pos = LatLng(
        state.userPosition!.latitude,
        state.userPosition!.longitude,
      );
      await _animatedMapMove(pos, 15);
    }
  }

  Future<void> _centerOnLot(ParkingLotModel lot) async {
    await _animatedMapMove(LatLng(lot.latitude, lot.longitude), 16);
  }

  Future<void> _animatedMapMove(LatLng destLocation, double destZoom) async {
    try {
      if (!_mapController.isCompleted) {
        return;
      }
      final GoogleMapController controller = await _mapController.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: destLocation, zoom: destZoom),
        ),
      );
    } catch (e) {
      debugPrint('Error moving camera: $e');
    }
  }

  Future<BitmapDescriptor> _getMarkerIcon(ParkingLotModel lot) async {
    final available = lot.totalSlots - (lot.totalSlots * lot.occupancy).toInt();
    final isFull = available <= 0;

    final rating = 3.5 + (lot.id.hashCode.abs() % 16) / 10.0;
    final cacheKey = '${lot.id}_${available}_${isFull}_rating';

    if (_markerIcons.containsKey(cacheKey)) {
      return _markerIcons[cacheKey]!;
    }

    final BitmapDescriptor icon = await _createCustomMarker(
      rating: rating,
      availableCount: available.toString(),
      color: isFull ? AppColors.error : AppColors.black,
    );
    _markerIcons[cacheKey] = icon;
    return icon;
  }

  Future<BitmapDescriptor> _createCustomMarker({
    required double rating,
    required String availableCount,
    required Color color,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    const double width = 260.0;
    const double height = 100.0;

    // Draw main bubble
    final Paint paint = Paint()..color = color;
    final RRect rRect = RRect.fromLTRBR(
      0,
      0,
      width,
      75,
      const Radius.circular(37.5),
    );
    canvas.drawRRect(rRect, paint);

    // Draw pointer triangle
    final ui.Path path = ui.Path()
      ..moveTo(width / 2 - 15, 75)
      ..lineTo(width / 2 + 15, 75)
      ..lineTo(width / 2, 95)
      ..close();
    canvas.drawPath(path, paint);

    // 1. Draw 'P' icon
    final TextPainter iconPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    iconPainter.text = TextSpan(
      text: String.fromCharCode(Icons.local_parking.codePoint),
      style: TextStyle(
        fontSize: 32,
        fontFamily: Icons.local_parking.fontFamily,
        package: Icons.local_parking.fontPackage,
        color: Colors.white,
      ),
    );
    iconPainter.layout();
    iconPainter.paint(canvas, Offset(20, (75 - iconPainter.height) / 2));

    // 2. Draw Rating
    final TextPainter ratingPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    ratingPainter.text = TextSpan(
      children: [
        TextSpan(
          text: rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextSpan(
          text: ' ${String.fromCharCode(Icons.star.codePoint)}',
          style: TextStyle(
            fontSize: 18,
            fontFamily: Icons.star.fontFamily,
            package: Icons.star.fontPackage,
            color: Colors.amber,
          ),
        ),
      ],
    );
    ratingPainter.layout();
    ratingPainter.paint(canvas, Offset(64, (75 - ratingPainter.height) / 2));

    // 3. Draw availability badge
    final Paint badgePaint = Paint()..color = AppColors.primary;
    final RRect badgeRRect = RRect.fromLTRBR(
      width - 80,
      15,
      width - 15,
      60,
      const Radius.circular(22),
    );
    canvas.drawRRect(badgeRRect, badgePaint);

    final TextPainter countPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    countPainter.text = TextSpan(
      text: availableCount,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    );
    countPainter.layout();
    countPainter.paint(
      canvas,
      Offset(
        width - 47.5 - countPainter.width / 2,
        (75 - countPainter.height) / 2,
      ),
    );

    final ui.Image image = await pictureRecorder.endRecording().toImage(
      width.toInt(),
      height.toInt(),
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    final parkingState = ref.watch(parkingProvider);
    final searchController = ref.watch(homeSearchControllerProvider);

    ref.listen(parkingProvider, (prev, next) {
      // Auto-center only once or when searching results arrive
      if (!_hasCenteredInitially &&
          (next.userPosition != null || next.lots.isNotEmpty)) {
        if (next.userPosition != null) {
          _centerOnUser(next);
        } else if (next.lots.isNotEmpty) {
          _centerOnLot(next.lots.first);
        }
        _hasCenteredInitially = true;
      }

      if (next.searchQuery != null &&
          next.searchQuery != searchController.text) {
        searchController.text = next.searchQuery!;
      }

      if (prev?.lots != next.lots) {
        _loadAllMarkerIcons();
      }
    });

    final initialPosition = parkingState.userPosition != null
        ? LatLng(
            parkingState.userPosition!.latitude,
            parkingState.userPosition!.longitude,
          )
        : (parkingState.lots.isNotEmpty
              ? LatLng(
                  parkingState.lots.first.latitude,
                  parkingState.lots.first.longitude,
                )
              : const LatLng(6.87, 79.88)); // Default to Colombo

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onTap: (_) => FocusScope.of(context).unfocus(),
            markers: parkingState.lots.map((lot) {
              return Marker(
                markerId: MarkerId(lot.id),
                position: LatLng(lot.latitude, lot.longitude),
                icon:
                    _markerIcons[lot.id] ??
                    BitmapDescriptor.defaultMarker, // Use _markerIcons
                anchor: const Offset(0.5, 1.0), // Point at tip of triangle
                onTap: () {
                  _centerOnLot(lot);
                  _showLotBottomSheet(context, ref, lot);
                },
              );
            }).toSet(),
          ),
          // Search Bar
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  children: [_buildSearchBar(context, searchController, ref)],
                ),
              ),
            ),
          ),
          if (parkingState.lots.isNotEmpty)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              height: 175,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: parkingState.lots.length,
                    onPageChanged: (index) {
                      _centerOnLot(parkingState.lots[index]);
                    },
                    itemBuilder: (context, index) {
                      final lot = parkingState.lots[index];
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ParkingLotCard(
                          lot: lot,
                          isSelected: false,
                          onTap: () {
                            _centerOnLot(lot);
                            _showLotBottomSheet(context, ref, lot);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          // Empty state
          if (!parkingState.isLoading &&
              parkingState.lots.isEmpty &&
              searchController.text.isNotEmpty)
            Positioned(
              bottom: 100,
              left: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No parking lots found',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      'Try a different location or search term',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (parkingState.isLoading)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: parkingState.lots.isNotEmpty ? 185 : 0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'refresh-fab',
              onPressed: () {
                ref.invalidate(parkingProvider);
                _hasCenteredInitially = false;
              },
              mini: true,
              backgroundColor: AppColors.white,
              child: const Icon(Icons.refresh, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: 'recenter-fab',
              onPressed: () {
                if (parkingState.userPosition != null) {
                  _centerOnUser(parkingState);
                } else if (parkingState.lots.isNotEmpty) {
                  _centerOnLot(parkingState.lots.first);
                }
              },
              backgroundColor: AppColors.white,
              child: const Icon(Icons.my_location, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  void _showLotBottomSheet(
    BuildContext context,
    WidgetRef ref,
    ParkingLotModel lot,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ParkingLotCard(lot: lot, isSelected: true),
            const SizedBox(height: 20),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
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
                setState(
                  () => _hasCenteredInitially = false,
                ); // Re-center on results
              },
            );
          },
          decoration: InputDecoration(
            hintText: context.l10n.searchLotHint,
            hintStyle: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary.withValues(alpha: 0.7),
            ),
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      controller.clear();
                      ref.read(parkingProvider.notifier).fetchLots();
                      setState(() => _hasCenteredInitially = false);
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }
}
