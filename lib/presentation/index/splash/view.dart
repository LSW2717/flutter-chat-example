import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_example/common/auth/auth_state_provider.dart';
import 'package:flutter_chat_example/common/router/routes/route/friends_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

import '../../../common/router/routes/route/index_route.dart';

class View extends ConsumerStatefulWidget {
  const View({super.key});

  @override
  ConsumerState<View> createState() => _ViewState();
}

class _ViewState extends ConsumerState<View> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () async {
        context.go(FriendsRoute.friendsPath);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(authProvider);
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Chat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Example',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        nextScreen: const View(),
        splashIconSize: 960,
        duration: 2000,
        centered: true,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
