import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/presentation/widgets/language_picker_button.dart';
import 'package:parkflow/routes/router_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          l10n.profile,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Profile Header
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? l10n.guest,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Settings Section
                _buildSection(context, [
                  _buildListTile(
                    icon: Icons.directions_car,
                    title: l10n.myVehicle,
                    subtitle: l10n.manageVehiclesSubtitle,
                    onTap: () {
                      const MyVehicleRoute().push(context);
                    },
                  ),
                  _buildListTile(
                    icon: Icons.payment,
                    title: l10n.profilePaymentMethods,
                    subtitle: l10n.profileManageCards,
                    onTap: () {
                      const PaymentMethodsRoute().push(context);
                    },
                  ),
                  _buildLanguageTile(context),
                ]),

                const SizedBox(height: 32),

                // Logout Section
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: _buildListTile(
                    icon: Icons.logout,
                    title: l10n.logout,
                    subtitle: l10n.settingsSignOutSubtitle,
                    color: AppColors.error,
                    onTap: () => ref.read(authProvider.notifier).logout(),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.translate, color: AppColors.primary, size: 24),
      ),
      title: Text(
        l10n.languageLabel,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.black87,
        ),
      ),
      subtitle: Text(
        l10n.languageSubtitle,
        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
      ),
      trailing: const LanguagePickerButton(),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (color ?? AppColors.primary).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: color ?? AppColors.primary, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: color ?? AppColors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
    );
  }
}
