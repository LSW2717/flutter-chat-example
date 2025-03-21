import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../const/typography.dart';

class AlarmMessage extends StatelessWidget {
  final String? title;
  final String content;

  const AlarmMessage({
    this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: title != null
          ? Text(
        title!,
        style: text20.copyWith(color: Colors.grey[800]),
      )
          : null,
      content: Text(
        content,
        style: text16.copyWith(color: Colors.grey[600]),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(
            '취소',
            style: text16.copyWith(color: Colors.grey[700]),
          ),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(
            '확인',
            style: text16,
          ),
        ),
      ],
    );
  }
}

Future<void> alert(
    BuildContext context,
    VoidCallback callBack,
    String title,
    String content,
    String errorMessage,
    ) async {
  final bool confirm = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlarmMessage(
        title: title,
        content: content,
      );
    },
  ) ??
      false;
  if (confirm) {
    try {
      callBack();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage, style: text16.copyWith(color: Colors.white),),
          duration: const Duration(milliseconds: 1000),
        ),
      );
    }
  }
}
