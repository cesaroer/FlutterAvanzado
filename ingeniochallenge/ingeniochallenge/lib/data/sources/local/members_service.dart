import 'package:flutter/services.dart';
import '../../../domain/models/member_model.dart';

abstract class AbstractMemberService {
  Future<List<Member>> getMembers();
}

class MembersService extends AbstractMemberService {
  Future<List<Member>> getMembers() async {
    final String response = await rootBundle.loadString('assets/members.json');
    final members = memberFromJson(response);
    return members;
  }
}
