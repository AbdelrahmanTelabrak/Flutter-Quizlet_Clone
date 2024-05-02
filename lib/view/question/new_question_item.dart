import 'package:flutter/material.dart';
import 'package:quizlet_clone/common/paddings.dart';
import 'package:quizlet_clone/view/widgets/textfields.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:quizlet_clone/viewmodel/study_set/single_term_viewmodel.dart';

class NewQuestionItem extends StatelessWidget {
  final SingleTermViewModel viewModel;
  final int index;

  const NewQuestionItem(
      {super.key, required this.viewModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (horizontalPadding * 2),
      // height: width/2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(),
        ],
      ),
      child: Form(
        key: viewModel.formKey,
        child: Padding(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              basicFormField(
                hint: 'Enter Term',
                validator: viewModel.basicValidator,
                onChanged: viewModel.updateTerm,
              ),
              const SizedBox(height: 15),
              basicFormField(
                hint: 'Enter Definition',
                validator: viewModel.basicValidator,
                onChanged: viewModel.updateDefinition,
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 15),
              boldText((index+1).toString(), color: Colors.grey, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
