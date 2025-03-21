import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Avatar extends ConsumerStatefulWidget {
  final String? avatarUrl;
  final double avatarSize;
  final EdgeInsets? margin;

  const Avatar({
    required this.avatarUrl,
    required this.avatarSize,
    this.margin,
    super.key,
  });

  @override
  ConsumerState<Avatar> createState() => _AvatarState();
}

class _AvatarState extends ConsumerState<Avatar> {

  String imgUrl = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = widget.avatarSize / 5 * 3;
    return Column(
      children: [
          Container(
            width: widget.avatarSize,
            height: widget.avatarSize,
            margin: widget.margin,
            decoration: BoxDecoration(
              color: Colors.grey[500],
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: iconSize,
                color: Colors.grey[50],
              ),
            ),
          ),
      ],
    );
  }
}
