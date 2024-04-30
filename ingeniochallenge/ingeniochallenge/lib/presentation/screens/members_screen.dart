import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingeniochallenge/presentation/bloc/members_bloc.dart';
import 'package:ingeniochallenge/presentation/widgets/loader_widget.dart';
import '../../data/sources/local/members_service.dart';
import '../../domain/models/member_model.dart';
import '../widgets/member_item_widget.dart';

class MembersScreen extends StatelessWidget {
  //final instance = MembersService();
  //bool getMembers = true;

  MembersScreen({
    super.key,
    required this.instance,
  });

  final MembersService instance;
  bool getMembers = false;

  @override
  Widget build(BuildContext context) {
    fetchMembers(context);
    return Container(
      child: context.select(
        (MembersBloc bloc) =>
            showViewContent(bloc.state.isLoading, bloc.state.members),
      ),
    );
  }

  Widget showViewContent(bool isLoading, List<Member> members) {
    print("DEBUG $isLoading y ${members.length}");
    if (isLoading == false && members.isEmpty) {
      return const Center(child: Text("no more team members"));
    }

    return !isLoading
        ? ListView.builder(
            itemCount: members.length,
            itemBuilder: (BuildContext context, int index) {
              return MemberItem(
                member: members[index],
                index: index,
              );
            },
          )
        : Loader();
  }

  void fetchMembers(BuildContext context) {
    if (getMembers) {
      context.read<MembersBloc>().simulateNetworkRequestEvent(instance);
      getMembers = false;
    }
  }
}
