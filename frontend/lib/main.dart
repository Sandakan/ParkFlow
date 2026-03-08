import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/repositories/repositories/env_repository.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/presentation/providers/locale_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Remove the # from URLs on web
  usePathUrlStrategy();

  final envRepository = await EnvRepository.create();

  runApp(
    ProviderScope(
      overrides: [envRepositoryProvider.overrideWithValue(envRepository)],
      child: const ParkFlowApp(),
    ),
  );
}

class ParkFlowApp extends ConsumerWidget {
  const ParkFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final baseTheme = ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF333233),
            primary: const Color(0xFF333233),
            surface: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        );

        final currentLocale = ref.watch(appLocaleProvider);

        return MaterialApp.router(
          title: 'ParkFlow',
          debugShowCheckedModeBanner: false,
          theme: baseTheme.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
            // Ensure components that use specific text styles also use Poppins
            primaryTextTheme: GoogleFonts.poppinsTextTheme(
              baseTheme.primaryTextTheme,
            ),
          ),
          locale: currentLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        );
      },
    );
  }
}
