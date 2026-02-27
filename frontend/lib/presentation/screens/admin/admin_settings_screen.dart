import 'package:flutter/material.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: Center(child: Text('${context.l10n.settings} - Coming Soon')),
    );
  }
}
