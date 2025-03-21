import 'package:flutter_chat_example/common/router/router.dart';
import 'package:flutter_chat_example/common/router/routes/route/index_route.dart';
import 'package:go_router/go_router.dart';
import '../../layout/shell_view.dart';
import '../../layout/shell_layout.dart';
import 'route/friends_route.dart';
import 'route/rooms_route.dart';

class AppRoutes {
  static final appRoutes = [
    ...IndexRoute.instance.routes,
    ...FriendsRoute.instance.routes,
    ...RoomsRoute.instance.routes,
    shellRoute,
  ];

  static final shellRoute = StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, navigationShell) {
      final List<ShellView> shellViews = [
        FriendsRoute.instance.shellView,
        RoomsRoute.instance.shellView,
      ];
      return noTransitionPage(
        child: ShellLayout(
          navigationShell: navigationShell,
          shellViews: shellViews,
        ),
      );
    },
    branches: [
      FriendsRoute.instance.shellBranch,
      RoomsRoute.instance.shellBranch,
    ],
  );
}
