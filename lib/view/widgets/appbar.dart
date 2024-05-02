import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/study_set/new_studyset_screen.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

import '../../common/colors.dart';

AppBar homeAppBar(BuildContext context) {
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
                // showModalBottomSheet(
                //   context: context,
                //   backgroundColor: lightBackground,
                //   showDragHandle: true,
                //   isScrollControlled: true,
                //   useSafeArea: true,
                //   builder: (context) {
                //     return Container();
                //   },
                // );
                _showAlertDialog(context);
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

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      bool isCreateQuizSelected = false;
      int selectedNumberOfQuestions = 5;

      return AlertDialog(
        title: Text('Choose an Option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Search by Code'),
              onTap: () {
                Navigator.pop(context, 'Search by Code');
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
          // TextButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //     // Perform actions based on the user's selection
          //   },
          //   child: Text('OK'),
          // ),
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
                      return NewStudySetPage(numberOfQuestions: selectedNumberOfQuestions);
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


