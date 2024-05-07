import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/common/providers/user_data_provider.dart';
import 'package:quizlet_clone/model/authentication/account_data.dart';
import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

import '../../common/colors.dart';
import 'buttons.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (BuildContext context, UserDataProvider value, Widget? child) {
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
                        backgroundImage: getProfilePic(value.accountData!.profilePic),
                        radius: 60,
                      ),
                      accountName: boldText(value.accountData!.username!,
                          size: 16, color: Colors.black),
                      accountEmail: regularText(value.accountData!.email!,
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
                    onPressed: () => value.logout(context),
                    child: semiBoldText('Log Out')),
              )
            ],
          ),
        );
      }
    );
  }

  ImageProvider<Object> getProfilePic(String? profilePic){
    if (profilePic != null) {
      return NetworkImage(profilePic);
    } else {
      return const AssetImage('assets/images/default_pic.png');
    }
  }
}
