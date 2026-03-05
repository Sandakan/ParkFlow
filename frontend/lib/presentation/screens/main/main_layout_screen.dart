import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
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
    );

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
              destinations: destinations
                  .map(
                    (d) => NavigationRailDestination(
                      icon: Icon(d.icon),
                      selectedIcon: Icon(d.selectedIcon),
                      label: Text(d.label),
                    ),
                  )
                  .toList(),
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) => _onTap(context, index),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
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
                    icon: Icon(d.icon),
                    activeIcon: Icon(d.selectedIcon),
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
  ) {
    if (authState.isAdmin) {
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
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings,
          label: context.l10n.settings,
        ),
      ];
    } else if (authState.isDriver) {
      return [
        NavigationDestinationData(
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
          label: context.l10n.home,
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

  NavigationDestinationData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
