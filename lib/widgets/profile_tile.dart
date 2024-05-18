import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        subtitle: Text(
          content,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w300,
            height: 0,
          ),
        ),
      ),
    );
  }
}
