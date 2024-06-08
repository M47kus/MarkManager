import 'package:flutter/material.dart';
import 'package:mark_manager/editor.dart';

Color getColor(double mark) {
  double percentage = 0;
  percentage = 100 / 5 * (mark - 1);
  return Color.lerp(Colors.green, Colors.red, percentage / 100)!;
}

double getAverage(List exam, List test) {
  double average = 0.0;
  double examAverage = 0.0;
  double testAverage = 0.0;
  for (int examMark in exam) {
    examAverage += examMark * 2;
  }
  for (int testMark in test) {
    testAverage += testMark;
  }

  if ((exam.length + test.length) != 0) {
    average = (examAverage + testAverage) / (exam.length * 2 + test.length);
  }

  return average;
}

// ignore: must_be_immutable
class Subject extends StatefulWidget {
  String title;
  List examMarks;
  List testMarks;
  Subject(
      {super.key,
      required this.title,
      required this.examMarks,
      required this.testMarks});

  @override
  State<Subject> createState() => SubjectState();
}

class SubjectState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          Text(
            "${getAverage(widget.examMarks, widget.testMarks)}",
            style: TextStyle(
                fontSize: 22,
                color:
                    getColor(getAverage(widget.examMarks, widget.testMarks))),
          ),
          const VerticalDivider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Exam:",
              style: TextStyle(fontSize: 16),
            ),
          ),
          for (int exam in widget.examMarks)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                exam.toString(),
                style:
                    TextStyle(color: getColor(exam.toDouble()), fontSize: 16),
              ),
            ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Test:",
              style: TextStyle(fontSize: 16),
            ),
          ),
          for (int test in widget.testMarks)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                test.toString(),
                style:
                    TextStyle(color: getColor(test.toDouble()), fontSize: 16),
              ),
            )
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Editor(
                      examMarks: widget.examMarks,
                      testMarks: widget.testMarks,
                      saveData: (List examData, List testData, String title) {
                        setState(() {
                          widget.examMarks = examData;
                          widget.testMarks = testData;
                          widget.title = title;
                        });
                      },
                      title: widget.title,
                    )));
      },

      // Row(
      //   children: [
      //     // for (int exam in widget.examMarks)
      //     //   SizedBox(
      //     //     width: 30,
      //     //     child: Text(
      //     //       "exam.toString(),",
      //     //       style: TextStyle(color: getColor(exam.toDouble())),
      //     //     ),
      //     //   )

      //   ],
      // ),
    );
  }
}
