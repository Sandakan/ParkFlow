import 'package:flutter/material.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.analytics)),
      body: Center(child: Text('${context.l10n.analytics} - Coming Soon')),
    );
  }
}
