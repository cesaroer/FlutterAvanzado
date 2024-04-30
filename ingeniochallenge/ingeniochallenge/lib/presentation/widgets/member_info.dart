import 'package:flutter/material.dart';

import 'member_desc.dart';

class MemberInformation extends StatelessWidget {
  final String avatarUrl;
  final String? name;
  final String? role;
  final String foregroundImageURL =
      "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png";

  const MemberInformation({
    super.key,
    required this.avatarUrl,
    this.name,
    this.role,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10.0),
        Image.network(
          width: 50,
          height: 50,
          avatarUrl,
          errorBuilder: (context, error, stackTrace) {
            return Image(
                image: NetworkImage(foregroundImageURL), width: 50, height: 50);
          },
        ),
        const SizedBox(width: 20.0),
        MemberDescription(
            name: name ?? "First Name Last Name", role: role ?? "missingrole"),
      ],
    );
  }
}
