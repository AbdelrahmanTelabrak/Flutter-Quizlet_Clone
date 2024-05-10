import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

import 'package:flutter/material.dart';

class MCQWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final Function(bool) onAnswer;

  MCQWidget({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.onAnswer,
  });

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  int? _selectedIndex;
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 2, spreadRadius: 5)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            mediumText(widget.question,
                                size: 16,
                                align: TextAlign.center,
                                color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 60,
                crossAxisSpacing: 20,
              ),
              children: List.generate(
                widget.options.length,
                (index) => GestureDetector(
                  onTap: () {
                    if (enabled) {
                      _selectedIndex = index;
                      enabled = false;
                      widget.onAnswer(widget.correctOptionIndex == index);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedIndex == null
                            ? Colors.grey
                            : _selectedIndex == index
                                ? widget.correctOptionIndex == index
                                    ? Colors.green
                                    : Colors.red
                                : widget.correctOptionIndex == index
                                    ? Colors.green
                                    : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: _selectedIndex == null
                          ? Colors.white
                          : _selectedIndex == index
                              ? widget.correctOptionIndex == index
                                  ? Colors.green
                                  : Colors.red
                              : widget.correctOptionIndex == index
                                  ? Colors.green
                                  : Colors.white,
                    ),
                    child: mediumText(
                      widget.options[index],
                      size: 16,
                      align: TextAlign.center,
                      color: _selectedIndex == null
                          ? Colors.black
                          : _selectedIndex == index
                              ? widget.correctOptionIndex == index
                                  ? Colors.white
                                  : Colors.white
                              : widget.correctOptionIndex == index
                                  ? Colors.white
                                  : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// class QuestionItem extends StatefulWidget {
//   // final
//   const QuestionItem({super.key});
//
//   @override
//   State<QuestionItem> createState() => _QuestionItemState();
// }
//
// class _QuestionItemState extends State<QuestionItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(color: Colors.grey)
//         ],
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: SingleChildScrollView(
//               child: mediumText('txt', size: 16, align: TextAlign.center),
//             ),
//           ),
//           // Expanded(),
//         ],
//       ),
//     );
//   }
// }
