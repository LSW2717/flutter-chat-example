import 'package:flutter/material.dart';

import '../../../../common/widget/avatar.dart';
import '../../../../data/remote/rooms/model/room_model.dart';
import '../../../../domain/ui_model/room_ui_model.dart';

class RoomsAvatar extends StatelessWidget {
  final List<RoomMemberUiModel> members;

  const RoomsAvatar({
    required this.members,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Column(
        children: [
          if (members.length <= 1 || members.isEmpty) _buildOnePerson(members),
          if (members.length == 2) _buildTwoPerson(members),
          if (members.length == 3) _buildThreePerson(members),
          if (members.length >= 4) _buildPeople(members),
        ],
      ),
    );
  }

  Widget _buildOnePerson(List<RoomMemberUiModel> members) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        children: [
          if (members.isEmpty)
            const Avatar(
              avatarUrl: '',
              avatarSize: 55,
            ),
          if (members.length == 1)
            const Avatar(
              avatarUrl: '',
              avatarSize: 55,
            ),
        ],
      ),
    );
  }

  Widget _buildTwoPerson(List<RoomMemberUiModel> members) {
    return const SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 40,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreePerson(List<RoomMemberUiModel> members) {
    return const SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 32,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 32,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 31,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeople(List<RoomMemberUiModel> members) {
    return const SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 30,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 30,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 30,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Avatar(
              avatarUrl: '',
              avatarSize: 30,
            ),
          ),
        ],
      ),
    );
  }

}
