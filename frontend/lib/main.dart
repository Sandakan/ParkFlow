import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/repositories/repositories/env_repository.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        return MaterialApp.router(
          title: 'ParkFlow',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        );
      },
    );
  }
}
