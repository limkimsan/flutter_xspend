import 'package:flutter/material.dart';
import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/constants/colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static const routeName = '/profile';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? profile;
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    User user = await User.currentLoggedIn();
    setState(() {
      profile = user;
    });
  }

  Widget profileItem(title, label) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: paleBlack)
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileItem('Name:', profile != null ? profile?.name : ""),
            const SizedBox(height: 16),
            profileItem('Email:', profile != null ? profile?.email : ""),
          ],
        )
      )
    );
  }
}