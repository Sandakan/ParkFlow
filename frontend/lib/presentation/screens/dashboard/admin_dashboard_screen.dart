import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/notifiers/settings/settings_notifier.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.adminDashboard),
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black87,
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
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.admin_panel_settings,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.adminWelcome,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.adminConsoleSubtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 48),
            _InferenceControlCard(),
          ],
        ),
      ),
    );
  }
}

class _InferenceControlCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.settingsGlobalInference,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: state.globalInferenceEnabled
                              ? AppColors.availableBackground
                              : AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: state.globalInferenceEnabled
                                    ? AppColors.availableText
                                    : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              state.globalInferenceEnabled
                                  ? l10n.settingsInferenceRunning
                                  : l10n.settingsInferenceStopped,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: state.globalInferenceEnabled
                                    ? AppColors.availableText
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Switch(
                  value: state.globalInferenceEnabled,
                  onChanged: (val) async {
                    notifier.updateGlobalInferenceEnabled(val);
                    await notifier.saveSettings();
                  },
                  activeThumbColor: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
