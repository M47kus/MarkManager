import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mark_manager/provider.dart';
import 'package:mark_manager/text_input.dart';

// ignore: must_be_immutable
class Editor extends StatefulWidget {
  List examMarks;
  List testMarks;
  String title;
  Function saveData;
  Editor(
      {super.key,
      required this.testMarks,
      required this.examMarks,
      required this.saveData,
      required this.title});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  List examTextControll = [];
  List testTextControll = [];
  TextEditingController titleTxt = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int mark in widget.examMarks) {
      examTextControll.add(TextEditingController(text: mark.toString()));
    }
    for (int mark in widget.testMarks) {
      testTextControll.add(TextEditingController(text: mark.toString()));
    }
    titleTxt.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            List saveExamMarks = [];
            List savetestMarks = [];
            for (TextEditingController txt in examTextControll) {
              saveExamMarks.add(int.parse(txt.text));
            }
            for (TextEditingController txt in testTextControll) {
              savetestMarks.add(int.parse(txt.text));
            }
            widget.saveData(saveExamMarks, savetestMarks, titleTxt.text);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 6, top: 6),
            child: SizedBox(
              width: 150,
              child: ConfigTextInput(label: "Name", controller: titleTxt),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 6.0, top: 6, bottom: 6),
            child: Text("Exam (2x)"),
          ),
        ),
        Row(
          children: [
            for (TextEditingController txt in examTextControll)
              SizedBox(
                width: 60,
                child: ConfigTextInput(label: "Mark", controller: txt),
              ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton.outlined(
                  onPressed: () {
                    setState(() {
                      examTextControll.add(TextEditingController(text: ""));
                    });
                  },
                  icon: const Icon(Icons.add)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton.outlined(
                  onPressed: () {
                    setState(() {
                      examTextControll.removeLast();
                    });
                  },
                  icon: const Icon(Icons.remove)),
            ),
          ],
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 6.0, top: 6, bottom: 6),
            child: Text("Test (1x)"),
          ),
        ),
        Row(children: [
          for (TextEditingController txt in testTextControll)
            SizedBox(
              width: 60,
              child: ConfigTextInput(label: "Mark", controller: txt),
            ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton.outlined(
                onPressed: () {
                  setState(() {
                    testTextControll.add(TextEditingController(text: ""));
                  });
                },
                icon: const Icon(Icons.add)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton.outlined(
                onPressed: () {
                  setState(() {
                    testTextControll.removeLast();
                  });
                },
                icon: const Icon(Icons.remove)),
          )
        ]),
        Align(child: Padding(
          padding: const EdgeInsets.only(left: 4, top: 4),
          child: IconButton(onPressed: () {Navigator.pop(context);
          ref.read(entityDataProvider.notifier)}, icon: Icon(Icons.delete_forever)),
        ), alignment: Alignment.topLeft,)
      ]),
    );
  }
}
