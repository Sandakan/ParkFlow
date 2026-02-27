import 'package:flutter/material.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class AdminParkingLotsScreen extends StatelessWidget {
  const AdminParkingLotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.parkingLots)),
      body: Center(child: Text('${context.l10n.parkingLots} - Coming Soon')),
    );
  }
}
