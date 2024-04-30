import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingeniochallenge/presentation/bloc/members_event.dart';
import 'package:ingeniochallenge/presentation/bloc/members_state.dart';

import '../../data/sources/local/members_service.dart';
import '../../domain/models/member_model.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  MembersBloc() : super(MembersState()) {
    on<MembersObtained>(_onMembersObtained);
    on<MembersRequested>(_onMembersRequested);
    on<MemberDeleted>(_onDeleteMembers);
  }

  void _onMembersObtained(MembersObtained event, Emitter<MembersState> emit) {
    emit(state.copyWith(
      members: event.members,
      isLoadin: false,
    ));
  }

  void _onMembersRequested(MembersRequested event, Emitter<MembersState> emit) {
    emit(state.copyWith(
      members: [],
      isLoadin: event.isLoading,
    ));
  }

  void simulateNetworkRequestEvent(MembersService service) async {
    add(MembersRequested(true));

    await Future.delayed(const Duration(seconds: 2));
    final members = await service.getMembers();

    add(MembersObtained(members));
  }

  void _onDeleteMembers(MemberDeleted event, Emitter<MembersState> emit) async {
    List<Member> newMembers = List<Member>.from(state.members);
    newMembers.removeAt(event.index);

    emit(state.copyWith(
      members: newMembers,
      isLoadin: false,
    ));
  }
}
