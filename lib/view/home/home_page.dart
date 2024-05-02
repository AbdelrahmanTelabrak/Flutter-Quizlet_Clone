import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizlet_clone/common/colors.dart';
import 'package:quizlet_clone/common/paddings.dart';
import 'package:quizlet_clone/view/quiz/quiz_item.dart';
import 'package:quizlet_clone/view/quiz/recent_quizzes_list.dart';
import 'package:quizlet_clone/view/widgets/appbar.dart';
import 'package:quizlet_clone/view/widgets/buttons.dart';
import 'package:quizlet_clone/view/widgets/drawer.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:quizlet_clone/viewmodel/home/home_viewmodel.dart';

import '../../model/authentication/account_data.dart';

class HomePage extends StatefulWidget {
  final AccountDataModel accountData;

  const HomePage({super.key, required this.accountData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    var quizzes = _viewModel.getMenuQuizzes();
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: homeAppBar(context),
      drawer: HomeDrawer(accountData: widget.accountData, logout: _viewModel.logout),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              semiBoldText('Recent', color: Colors.black, size: 18),
              defaultDivider(),
              // list view . builder for the questions
              RecentQuizzesListView(quizzesList: quizzes),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox defaultDivider() {
    return const SizedBox(height: 15);
  }
}
