import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/common/colors.dart';
import 'package:quizlet_clone/common/paddings.dart';
import 'package:quizlet_clone/view/quiz/recent_quizzes_list.dart';
import 'package:quizlet_clone/view/widgets/appbar.dart';
import 'package:quizlet_clone/view/widgets/drawer.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:quizlet_clone/viewmodel/home/home_viewmodel.dart';

import '../../common/providers/menu_quizzes_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMenuQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: homeAppBar(context, (menuQuiz) {
        Provider.of<MenuQuizzesProvider>(context, listen: false)
            .addQuizzes([menuQuiz]);
      }),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              semiBoldText('My Quizzes', color: Colors.black, size: 18),
              defaultDivider(),
              // list view . builder for the questions
              RecentQuizzesListView(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox defaultDivider() {
    return const SizedBox(height: 15);
  }

  void initMenuQuizzes() async {
    final context = this.context; // Save the context
    await _viewModel.getMenuQuizzes(context);
    if (mounted) {
      // Check if the widget is still mounted before calling setState
      setState(() {});
    }
  }
}
