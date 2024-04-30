import 'package:flutter/material.dart';

class MemberDescription extends StatelessWidget {
  final String name;
  final String role;

  const MemberDescription({super.key, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(role),
      ],
    );
  }
}
