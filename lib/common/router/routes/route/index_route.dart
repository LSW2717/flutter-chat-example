import 'package:go_router/go_router.dart';
import '../../../layout/shell_view.dart';
import '../../router.dart';
import 'app_route.dart';
import 'package:flutter_chat_example/presentation/index/splash/view.dart' as splash;
import 'package:flutter_chat_example/presentation/index/login/view.dart' as login;
class IndexRoute extends AppRoute {
  IndexRoute._privateConstructor();

  static final IndexRoute _instance = IndexRoute._privateConstructor();

  static IndexRoute get instance => _instance;

  static String get splashPath => '/';

  static String get loginPath => '/login';

  @override
  List<RouteBase> routes = [
    GoRoute(
      path: splashPath,
      pageBuilder: (context, state) => noTransitionPage(
        child: const splash.View(),
      ),
    ),
    GoRoute(
      path: loginPath,
      pageBuilder: (context, state) => noTransitionPage(
        child: const login.View(),
      ),
    ),
  ];

  @override
  StatefulShellBranch get shellBranch => throw UnimplementedError();

  @override
  ShellView get shellView => throw UnimplementedError();
}
