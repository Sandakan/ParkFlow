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
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }

  List<NavigationDestinationData> _getDestinations(
    BuildContext context,
    AuthState authState,
  ) {
    if (authState.isAdmin) {
      return [
        NavigationDestinationData(
          icon: Icons.dashboard_outlined,
          selectedIcon: Icons.dashboard,
          label: context.l10n.adminDashboard,
        ),
        NavigationDestinationData(
          icon: Icons.videocam_outlined,
          selectedIcon: Icons.videocam,
          label: context.l10n.liveFeed,
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
