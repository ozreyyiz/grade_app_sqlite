import 'package:flutter/material.dart';
import 'package:grade_app_sqlite/db/gradedao.dart';
import 'package:grade_app_sqlite/model/grade.dart';
import 'package:grade_app_sqlite/pages/grade_page.dart';

class DetailPage extends StatefulWidget {
  final Grade grade;

  DetailPage({required this.grade});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var gradeNameCntrl = TextEditingController();
  var note1Cntrl = TextEditingController();
  var note2Cntrl = TextEditingController();

  Future<void> delete(int note_id) async {
    await Gradedao().deleteGrade(note_id);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => GradePage()));
  }

  Future<void> update(
      int note_id, String gradeName, int note1, int note2) async {
    await Gradedao().updateGrade(note_id, gradeName, note1, note2);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => GradePage()));
  }

  @override
  void initState() {
    super.initState();
    var grade = widget.grade;
    gradeNameCntrl.text = grade.grade_name;
    note1Cntrl.text = grade.grade_first.toString();
    note2Cntrl.text = grade.grade_second.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        actions: [
          TextButton(
            onPressed: () {
              update(widget.grade.grade_id, gradeNameCntrl.text,
                  int.parse(note1Cntrl.text), int.parse(note2Cntrl.text));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => GradePage()));
            },
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              delete(widget.grade.grade_id);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => GradePage()));
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: gradeNameCntrl,
                decoration: InputDecoration(labelText: "lesson"),
              ),
              TextField(
                controller: note1Cntrl,
                decoration: InputDecoration(labelText: "Note 1"),
              ),
              TextField(
                controller: note2Cntrl,
                decoration: InputDecoration(labelText: "Note 2"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
