import 'package:grade_app_sqlite/db/dbhelper.dart';
import 'package:grade_app_sqlite/model/grade.dart';

class Gradedao {
  Future<List<Grade>> getGrades() async {
    var db = await DbHelper.dbAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM grades");
    return List.generate(maps.length, (i) {
      var line = maps[i];
      return Grade(line["grade_id"], line["grade_name"], line["grade_first"],
          line["grade_second"]);
    });
  }

  Future<void> addGrade(String grade_name, int note1, int note2) async {
    var db = await DbHelper.dbAccess();

    var datas = Map<String, dynamic>();
    datas["grade_name"] = grade_name;
    datas["grade_first"] = note1;
    datas["grade_second"] = note2;
    await db.insert("grades", datas);
  }

  Future<void> updateGrade(
      int garde_id, String grade_name, int note1, int note2) async {
    var db = await DbHelper.dbAccess();

    var datas = Map<String, dynamic>();
    datas["grade_name"] = grade_name;
    datas["grade_first"] = note1;
    datas["grade_second"] = note2;
    await db
        .update("grades", datas, where: "grade_id =?", whereArgs: [garde_id]);
  }

  Future<void> deleteGrade(
      int garde_id) async {
    var db = await DbHelper.dbAccess();

    await db.delete("grades", where: "grade_id =?", whereArgs: [garde_id]);
  }
}
