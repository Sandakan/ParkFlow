import 'package:flutter/material.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class AdminCamerasScreen extends StatelessWidget {
  const AdminCamerasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.cameras)),
      body: Center(child: Text('${context.l10n.cameras} - Coming Soon')),
    );
  }
}
