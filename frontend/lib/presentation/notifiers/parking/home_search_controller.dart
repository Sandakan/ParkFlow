import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';

part 'home_search_controller.g.dart';

@riverpod
TextEditingController homeSearchController(Ref ref) {
  final initialQuery = ref.read(parkingProvider).searchQuery ?? '';
  final controller = TextEditingController(text: initialQuery);

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
}
