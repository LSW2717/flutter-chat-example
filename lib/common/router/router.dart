import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_example/common/router/routes/route/index_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/auth_state_provider.dart';
import 'routes/app_routes.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final isAuth = ValueNotifier<bool>(false);

  ref
    ..onDispose(isAuth.dispose)
    ..listen(
      authProvider.select((value) => value.isLogin),
          (_, next) {
        isAuth.value = next;
      },
    );

  return GoRouter(
    initialLocation: IndexRoute.splashPath,
    navigatorKey: rootNavigatorKey,
    restorationScopeId: 'router',
    refreshListenable: isAuth,
    routes: AppRoutes.appRoutes,
    redirect: (BuildContext context, GoRouterState state) {
      print(state.uri.path);
      final isSplash = state.uri.path == IndexRoute.splashPath;

      if(isSplash){
        return null;
      }

      if(!isAuth.value){
        return IndexRoute.loginPath;
      }

      return null;
    },
  );
}

Page<dynamic> platformPage({
  required Widget child,
  bool? fullScreenDialog,
}) {
  return Platform.isIOS
      ? CupertinoPage<void>(
    child: child,
    fullscreenDialog: fullScreenDialog ?? false,
  )
      : MaterialPage<void>(
    child: child,
    fullscreenDialog: fullScreenDialog ?? false,
  );
}

Page<dynamic> noTransitionPage({
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
