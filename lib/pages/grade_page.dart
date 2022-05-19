import 'package:flutter/material.dart';
import 'package:grade_app_sqlite/db/gradedao.dart';
import 'package:grade_app_sqlite/model/grade.dart';
import 'package:grade_app_sqlite/pages/add_grade_page.dart';
import 'package:grade_app_sqlite/pages/detail_page.dart';

class GradePage extends StatefulWidget {
  GradePage({Key? key}) : super(key: key);

  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  var grades = <Grade>[];
  Future<List<Grade>> getGrades() async {
    grades = await Gradedao().getGrades();
    return grades;
  }

  int first_grade = 0;
  int second_grade = 0;
  double total = 0;
  double avr = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text("Grade App"),
        actions: [
          FutureBuilder(
            future: getGrades(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var gradeList = snapshot.data;
                double avr = 0;
                if (!gradeList.isEmpty) {
                  double total = 0;

                  for (Grade n in gradeList) {
                    total = total + (n.grade_first + n.grade_second) / 2;
                  }

                  avr = total / gradeList.length;
                }

                return Center(
                  child: Text("Avarage : ${avr.toInt()}"),
                );
              } else {}
              return Center(
                child: Text("Avarage : 0"),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddGradePage()));
        },
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: Center(child: Text("Lesson"))),
              Expanded(child: Center(child: Text("Grade 1."))),
              Expanded(child: Center(child: Text("Grade 2."))),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: getGrades(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var grades = snapshot.data;
                  return ListView.builder(
                    itemCount: grades.length,
                    itemBuilder: (BuildContext context, int index) {
                      Grade grade = grades[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(grade: grade,)));
                          },
                          child: SizedBox(
                            height: 60,
                            child: Card(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Center(
                                          child: Text(grade.grade_name))),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                              grade.grade_first.toString()))),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                              grade.grade_second.toString()))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
