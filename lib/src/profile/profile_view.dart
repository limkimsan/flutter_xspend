import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.profile)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileItem('${AppLocalizations.of(context)!.name}:', profile != null ? profile?.name : ""),
            const SizedBox(height: 16),
            profileItem('${AppLocalizations.of(context)!.email}:', profile != null ? profile?.email : ""),
          ],
        )
      )
    );
  }
}