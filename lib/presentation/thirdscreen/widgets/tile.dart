import 'package:flutter/material.dart';

import '../../../core/constraint/colors.dart';
import '../../../data/models/user_model.dart';
import '../../secondscreen/pages/second_screen_page.dart';
import '../pages/third_screen_page.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.widget,
    required this.users,
  });

  final ThirdScreen widget;
  final Data users;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondScreen(
                name: widget.name,
                user: "${users.firstName} ${users.lastName}"),
          ),
        );
      },
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(
          users.avatar,
        ),
      ),
      title: Text(
        '${users.firstName} ${users.lastName}',
        style: const TextStyle(
          color: AppColors.dark,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        users.email,
        style: TextStyle(
          color: AppColors.dark.withOpacity(0.6),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
