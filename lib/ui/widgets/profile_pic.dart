import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String profilePicUrl;
  const ProfilePic(this.profilePicUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        height: 120,
        width: 120,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.yellow[600],
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Image.network(
            profilePicUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
