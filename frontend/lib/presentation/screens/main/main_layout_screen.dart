import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/notifiers/notification/notification_notifier.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class MainLayoutScreen extends ConsumerWidget {
  const MainLayoutScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 600;
    final authState = ref.watch(authProvider);
    final colorScheme = Theme.of(context).colorScheme;

    final List<NavigationDestinationData> destinations = _getDestinations(
      context,
      authState,
      ref,
    );

    if (destinations.length < 2) {
      return Scaffold(body: navigationShell);
    }

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: size.width >= 800,
              labelType: size.width >= 800 ? null : NavigationRailLabelType.all,
              selectedLabelTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              unselectedLabelTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              selectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              unselectedIconTheme: IconThemeData(
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                size: 24,
              ),
              selectedIndex: navigationShell.currentIndex,
              destinations: destinations
                  .map(
                    (d) => NavigationRailDestination(
                      icon: Badge(
                        label: d.badgeCount != null ? Text(d.badgeCount.toString()) : null,
                        isLabelVisible: d.badgeCount != null,
                        child: Icon(d.icon),
                      ),
                      selectedIcon: Badge(
                        label: d.badgeCount != null ? Text(d.badgeCount.toString()) : null,
                        isLabelVisible: d.badgeCount != null,
                        child: Icon(d.selectedIcon),
                      ),
                      label: Text(d.label),
                    ),
                  )
                  .toList(),
              onDestinationSelected: (index) => _onTap(context, index),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
        floatingActionButton: null,
      );
    }

    return Scaffold(
      body: navigationShell,
      floatingActionButton: null,
      floatingActionButtonLocation: null,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onSurfaceVariant,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            selectedIconTheme: IconThemeData(
              color: colorScheme.primary,
              size: 28,
            ),
            unselectedIconTheme: IconThemeData(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              size: 24,
            ),
            items: destinations
                .map(
                  (d) => BottomNavigationBarItem(
                    icon: Badge(
                      label: d.badgeCount != null ? Text(d.badgeCount.toString()) : null,
                      isLabelVisible: d.badgeCount != null,
                      child: Icon(d.icon),
                    ),
                    activeIcon: Badge(
                      label: d.badgeCount != null ? Text(d.badgeCount.toString()) : null,
                      isLabelVisible: d.badgeCount != null,
                      child: Icon(d.selectedIcon),
                    ),
                    label: d.label,
                  ),
                )
                .toList(),
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => _onTap(context, index),
          ),
        ],
      ),
    );
  }

  List<NavigationDestinationData> _getDestinations(
    BuildContext context,
    AuthState authState,
    WidgetRef ref,
  ) {
    if (authState.isAdmin) {
      final unreadCount = ref.watch(notificationProvider).maybeWhen(
            data: (notifications) => notifications.where((n) => n.readAt == null).length,
            orElse: () => 0,
          );
      return [
        NavigationDestinationData(
          icon: Icons.bar_chart_outlined,
          selectedIcon: Icons.bar_chart,
          label: context.l10n.analytics,
        ),
        NavigationDestinationData(
          icon: Icons.local_parking_outlined,
          selectedIcon: Icons.local_parking,
          label: context.l10n.parkingLots,
        ),
        NavigationDestinationData(
          icon: Icons.videocam_outlined,
          selectedIcon: Icons.videocam,
          label: context.l10n.cameras,
        ),
        NavigationDestinationData(
          icon: Icons.qr_code_scanner_outlined,
          selectedIcon: Icons.qr_code_scanner,
          label: context.l10n.reservations,
        ),
        NavigationDestinationData(
          icon: Icons.notifications_outlined,
          selectedIcon: Icons.notifications,
          label: context.l10n.notifications,
          badgeCount: unreadCount > 0 ? unreadCount : null,
        ),
        NavigationDestinationData(
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings,
          label: context.l10n.settings,
        ),
      ];
    } else if (authState.isDriver) {
      final unreadCount = ref.watch(notificationProvider).maybeWhen(
            data: (notifications) => notifications.where((n) => n.readAt == null).length,
            orElse: () => 0,
          );
      return [
        NavigationDestinationData(
          icon: Icons.dashboard_outlined,
          selectedIcon: Icons.dashboard_rounded,
          label: context.l10n.explore,
        ),
        NavigationDestinationData(
          icon: Icons.bookmark_outline,
          selectedIcon: Icons.bookmark_added,
          label: context.l10n.bookings,
        ),
        NavigationDestinationData(
          icon: Icons.notifications_outlined,
          selectedIcon: Icons.notifications,
          label: context.l10n.notifications,
          badgeCount: unreadCount > 0 ? unreadCount : null,
        ),
        NavigationDestinationData(
          icon: Icons.directions_car_outlined,
          selectedIcon: Icons.directions_car,
          label: context.l10n.myVehicle,
        ),
        NavigationDestinationData(
          icon: Icons.person_outline,
          selectedIcon: Icons.person,
          label: context.l10n.profile,
        ),
      ];
    }
    return [];
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class NavigationDestinationData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final int? badgeCount;

  NavigationDestinationData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.badgeCount,
  });
}
