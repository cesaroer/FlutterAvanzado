import '../../domain/models/member_model.dart';

abstract class MembersEvent {
  const MembersEvent();
}

class MembersObtained extends MembersEvent {
  final List<Member> members;

  MembersObtained(this.members);
}

class MembersRequested extends MembersEvent {
  final bool isLoading;

  MembersRequested(this.isLoading);
}

class MemberDeleted extends MembersEvent {
  final int index;

  MemberDeleted(this.index);
}
