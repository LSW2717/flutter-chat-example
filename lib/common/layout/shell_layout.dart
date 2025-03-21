import 'package:flutter/material.dart';
import 'package:flutter_chat_example/common/layout/shell_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ShellLayout extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  final List<ShellView> shellViews;

  const ShellLayout({
    required this.navigationShell,
    required this.shellViews,
    super.key,
  });

  void _goBranch(int index, WidgetRef ref) async {
    await shellViews[index].onTap(ref);
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: shellViews[navigationShell.currentIndex].appBar(context, ref),
      backgroundColor: Colors.white,
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          currentIndex: navigationShell.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (index){
            _goBranch(index, ref);
          },
          items: [
            ...shellViews.map(
                  (view) => view.navItem(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
