import 'package:flutter/material.dart';
import 'package:quizlet_clone/common/paddings.dart';
import 'package:quizlet_clone/view/question/new_question_item.dart';
import 'package:quizlet_clone/view/widgets/buttons.dart';
import 'package:quizlet_clone/view/widgets/textfields.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:quizlet_clone/viewmodel/study_set/terms_viewmodel.dart';

class NewStudySetPage extends StatelessWidget {
  final int numberOfQuestions;

  const NewStudySetPage({super.key, required this.numberOfQuestions});

  @override
  Widget build(BuildContext context) {
    var viewModel = TermsViewModel(numberOfQuestions);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
        ),
        child: Column(    // Todo: search for Constrains
          // mainAxisSize: MainAxisSize.min,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                return NewQuestionItem(
                    viewModel: viewModel.termsViewModel[index], index: index);
              },
              itemCount: viewModel.termsViewModel.length,
            ),
            const SizedBox(height: 15),
            filledFullWidthButton(
              onPressed: () {
                viewModel.submit(context);
              },
              child: boldText('Create', size: 16, color: Colors.white),
            ),
            // const SizedBox(height: 300),
          ],
        ),
      ),
    );
  }
}
