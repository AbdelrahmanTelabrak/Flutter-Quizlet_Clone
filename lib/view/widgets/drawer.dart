import 'package:flutter/material.dart';
import 'package:quizlet_clone/model/authentication/account_data.dart';
import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

import '../../common/colors.dart';
import 'buttons.dart';

class HomeDrawer extends StatelessWidget {

  final AccountDataModel accountData;
  final Future<void> Function(BuildContext context) logout;
  const HomeDrawer({super.key, required this.accountData, required this.logout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: lightBackground,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: getProfilePic(),
                    radius: 60,
                  ),
                  accountName: boldText(accountData.username!,
                      size: 16, color: Colors.black),
                  accountEmail: regularText(accountData.email!,
                      size: 14, color: Colors.black),
                ),
                ListTile(
                  title: semiBoldText('Notifications',
                      color: Colors.black, size: 18),
                  leading: const Icon(
                    Icons.notifications_none_sharp,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                ListTile(
                  title: semiBoldText('Achievements',
                      color: Colors.black, size: 18),
                  leading: const Icon(
                    Icons.emoji_events_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                ListTile(
                  title:
                  semiBoldText('Settings', color: Colors.black, size: 18),
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                ListTile(
                  title: semiBoldText('Dark Mode',
                      color: Colors.black, size: 18),
                  leading: const Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: outlinedFullWidthButton(
                onPressed: () => logout(context),
                child: semiBoldText('Log Out')),
          )
        ],
      ),
    );
  }

  ImageProvider<Object> getProfilePic(){
    if ((accountData.profilePic != null)) {
      return NetworkImage(accountData.profilePic!);
    } else {
      return const AssetImage('assets/images/default_pic.png');
    }
  }
}
