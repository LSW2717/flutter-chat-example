import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ShellView {
  AppBar appBar(BuildContext context, WidgetRef ref);

  BottomNavigationBarItem navItem(BuildContext context, WidgetRef ref);

  Future<void> onTap(WidgetRef ref);
}