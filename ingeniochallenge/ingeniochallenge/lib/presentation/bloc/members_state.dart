import 'package:equatable/equatable.dart';
import '../../domain/models/member_model.dart';

class MembersState extends Equatable {
  List<Member> members;
  bool isLoading;

  MembersState({
    this.members = const [],
    this.isLoading = false,
  });

  MembersState copyWith({
    List<Member>? members,
    bool? isLoadin,
  }) =>
      MembersState(
        members: members ?? this.members,
        isLoading: isLoadin ?? this.isLoading,
      );

  @override
  List<Object?> get props => [members, isLoading];
}
