import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/providers/locale_provider.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class LanguagePickerButton extends ConsumerWidget {
  final bool isDark;

  const LanguagePickerButton({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(appLocaleProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.black87
            : AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? AppColors.white.withValues(alpha: 0.1)
              : AppColors.outlineVariant,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLocale.languageCode,
          icon: Icon(
            Icons.language_rounded,
            size: 18,
            color: isDark ? AppColors.white : AppColors.primary,
          ),
          elevation: 8,
          dropdownColor: isDark ? AppColors.black87 : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          onChanged: (String? newValue) {
            if (newValue != null) {
              ref.read(appLocaleProvider.notifier).setLocale(Locale(newValue));
            }
          },
          selectedItemBuilder: (context) {
            return ['en', 'si', 'ta'].map((String value) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    value.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: isDark ? AppColors.white : AppColors.primary,
                    ),
                  ),
                ),
              );
            }).toList();
          },
          items: const [
            DropdownMenuItem(
              value: 'en',
              child: Text(
                'English',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            DropdownMenuItem(
              value: 'si',
              child: Text(
                'සිංහල',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            DropdownMenuItem(
              value: 'ta',
              child: Text(
                'தமிழ்',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
