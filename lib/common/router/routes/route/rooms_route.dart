import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../presentation/rooms/index/view.dart' as rooms;
import '../../../../presentation/rooms/chat/view.dart' as chat;
import '../../../layout/shell_view.dart';
import '../../router.dart';
import 'app_route.dart';

final roomsShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rooms');

class RoomsRoute extends AppRoute {
  RoomsRoute._privateConstructor();

  static final RoomsRoute _instance = RoomsRoute._privateConstructor();

  static RoomsRoute get instance => _instance;

  static String get roomsPath => '/rooms';

  static String chatKey(String id) => '/rooms/$id';

  @override
  List<RouteBase> routes = [
    GoRoute(
      path: '/rooms/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return platformPage(
          child: chat.View(
            roomId: id,
          ),
        );
      },
    )
  ];

  @override
  StatefulShellBranch shellBranch = StatefulShellBranch(
    navigatorKey: roomsShellNavigatorKey,
    routes: [
      GoRoute(
        path: roomsPath,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: rooms.View(),
        ),
      ),
    ],
  );

  @override
  ShellView get shellView => const rooms.View();
}
