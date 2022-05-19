import 'package:flutter/material.dart';
import 'package:grade_app_sqlite/db/gradedao.dart';
import 'package:grade_app_sqlite/pages/grade_page.dart';
import 'package:path/path.dart';

class AddGradePage extends StatefulWidget {
  AddGradePage({Key? key}) : super(key: key);

  @override
  _AddGradePageState createState() => _AddGradePageState();
}

class _AddGradePageState extends State<AddGradePage> {
  var gradeNameCntrl = TextEditingController();
  var note1Cntrl = TextEditingController();
  var note2Cntrl = TextEditingController();

  Future<void> add(String gradeName, int note1, int note2) async {
  await Gradedao().addGrade(gradeName, note1, note2);
    Navigator.pushReplacement(
        this.context, MaterialPageRoute(builder: (context) => GradePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Grade Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: gradeNameCntrl,
                decoration: InputDecoration(hintText: "Lesson Name"),
              ),
              TextField(
                controller: note1Cntrl,
                decoration: InputDecoration(hintText: "Note 1"),
              ),
              TextField(
                controller: note2Cntrl,
                decoration: InputDecoration(hintText: "Note 2"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          add(
            gradeNameCntrl.text,
            int.parse(note1Cntrl.text),
            int.parse(note2Cntrl.text),
          );
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
        tooltip: "Note Save",
      ),
    );
  }
}
