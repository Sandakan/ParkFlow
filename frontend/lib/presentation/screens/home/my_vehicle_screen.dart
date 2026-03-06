import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class MyVehicleScreen extends ConsumerWidget {
  const MyVehicleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.myVehicle)),
      body: const Center(child: Text('Vehicle details and parking history.')),
    );
  }
}
