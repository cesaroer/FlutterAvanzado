import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingeniochallenge/domain/models/member_model.dart';
import 'package:ingeniochallenge/presentation/bloc/members_bloc.dart';
import 'package:ingeniochallenge/presentation/bloc/members_event.dart';

import 'bio_widget.dart';
import 'member_info.dart';

class MemberItem extends StatelessWidget {
  final Member member;
  final int index;

  const MemberItem({
    super.key,
    required this.member,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                MemberInformation(
                  avatarUrl: member.avatar,
                  name: member.getCompleteName(),
                  role: member.title,
                ),
                const SizedBox(height: 10.0),
                BiographyWidget(text: member.bio),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<MembersBloc>().add(MemberDeleted(index));
            },
            child: const Icon(
              Icons.restore_from_trash_rounded,
              color: Colors.blueGrey,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
