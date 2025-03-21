import 'package:flutter/material.dart';
import 'package:flutter_chat_example/common/auth/auth_state_provider.dart';
import 'package:flutter_chat_example/common/router/routes/route/friends_route.dart';
import 'package:flutter_chat_example/common/router/routes/route/rooms_route.dart';
import 'package:flutter_chat_example/domain/repository/users_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_json/pretty_json.dart';

import '../../../common/router/routes/route/index_route.dart';

class View extends ConsumerStatefulWidget {
  const View({super.key});

  @override
  ConsumerState<View> createState() => _ViewState();
}

class _ViewState extends ConsumerState<View> {
  late TextEditingController textController;
  late UsersRepository usersRepository;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    usersRepository = ref.watch(usersRepositoryProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(text?.login ?? ""),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('이름을 입력해주세요'),
              TextField(controller: textController),
              Gap(20),
              ElevatedButton(
                onPressed: () async {
                  final user = await usersRepository.createUser(
                    userName: textController.text,
                  );
                  final currentUser = await usersRepository.readUser(user.userId);
                  ref.read(authProvider.notifier).setUser(currentUser);
                  context.go(FriendsRoute.friendsPath);
                },
                child: Text('로그인하기'),
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }
}
