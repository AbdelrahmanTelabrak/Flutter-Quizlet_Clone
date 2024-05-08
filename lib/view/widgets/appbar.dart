import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/common/providers/menu_quizzes_provider.dart';
import 'package:quizlet_clone/view/study_set/new_studyset_screen.dart';
import 'package:quizlet_clone/view/widgets/commons.dart';
import 'package:quizlet_clone/view/widgets/textfields.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:quizlet_clone/viewmodel/home/home_viewmodel.dart';

import '../../common/colors.dart';

AppBar homeAppBar(BuildContext context, Function? providerFun) {
  return AppBar(
    title: boldText('Quizlet', size: 32, color: mainColor),
    titleSpacing: 0,
    actions: [
      Row(
        children: [
          SizedBox(
            width: 42,
            height: 42,
            child: FloatingActionButton(
              onPressed: () {
                _showAlertDialog(context, providerFun!);
              },
              backgroundColor: mainColor,
              shape: const OvalBorder(),
              elevation: 0,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      )
    ],
  );
}

void _showAlertDialog(BuildContext context, Function providerFun) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose an Option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Search by Code'),
              onTap: () {
                Navigator.pop(context, 'Search by Code');
                _showAddByCodeDialog(context, providerFun);
              },
            ),
            ListTile(
              title: Text('Create a New Quiz'),
              onTap: () {
                // isCreateQuizSelected = true;
                Navigator.pop(context, 'Create a New Quiz');
                _showNumberOfQuestions(context);
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

void _showNumberOfQuestions(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      int selectedNumberOfQuestions = 5;
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Choose an Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<int>(
                  value: selectedNumberOfQuestions,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedNumberOfQuestions = newValue!;
                    });
                  },
                  items: List.generate(
                    16,
                    (index) => DropdownMenuItem<int>(
                      value: index + 5,
                      child: Text('${index + 5} Questions'),
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Perform actions based on the user's selection
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    // enableDrag: false,
                    backgroundColor: lightBackground,
                    showDragHandle: true,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return NewStudySetPage(
                          numberOfQuestions: selectedNumberOfQuestions);
                    },
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    },
  );
}

void _showAddByCodeDialog(BuildContext context, Function providerFun) async {
  final viewModel = HomeViewModel();
  String quizCode = '';
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: semiBoldText('Enter Quiz code:', size: 16),
        content: basicFormField(
          hint: 'Quiz Code',
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter the quiz code.';
            }
            return null;
          },
          onChanged: (p0) => quizCode = p0,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Perform actions based on the user's selection
              Navigator.pop(context);
              if (quizCode.isNotEmpty && quizCode.length == 8) {
                // Navigator.pop(context);
                final menuQuiz = await viewModel.getQuizByCode(context, quizCode);
                providerFun(menuQuiz);
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(mainSnackBar('Invalid Code'));
              }
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
