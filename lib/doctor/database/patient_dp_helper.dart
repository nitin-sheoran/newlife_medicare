import 'package:newlife_medicare/category/model/category_model_class.dart';
import 'package:newlife_medicare/doctor/model/doctor_model_class.dart';
import 'package:newlife_medicare/patient/model/patient_model_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PatientDpHelper {
  static late Database database;
  static String patientTable = 'patient';
  static String id = 'Id';
  static String name = 'Name';
  static String disease = 'Disease';
  static String fees = 'Fees';
  static String doctor = 'Doctor';
  static String address = 'Address';

  static String doctorTable = 'Doctor';
  static String id1 = 'Id';
  static String name1 = 'Name';
  static String specialist = 'Specialist';
  static String fees1 = 'Fees';
  static String timing = 'Timing';
  static String imPath = 'Path';

  static String categoryTable = 'category';
  static String id2 = 'Id';
  static String category = 'Category';

  static Future createDatabase() async {
    String dbName = 'hospital.db';
    String path = await getDatabasesPath();
    String dbPath = join(path, dbName);
    database =
        await openDatabase(dbPath, version: 1, onCreate: (database, version) {
      database.execute(
          "create table $patientTable($id int primary key,$name text,$disease text,$fees int,$doctor text,$address text)");
      print('table create successfully');
      database.execute(
          "create table $doctorTable($id1 int primary key,$name1 text,$specialist text,$fees1 int,$timing int,$imPath text)");
      print('table create successfully');
      database.execute(
          "create table $categoryTable($id2 int primary key,$category text)");
      print('Table create successfully');
    });
  }

  static Future addPatient(PatientModel patientModel) async {
    await database.rawInsert("insert into $patientTable values(?,?,?,?,?,?)", [
      patientModel.id,
      patientModel.name,
      patientModel.disease,
      patientModel.fees,
      patientModel.doctor,
      patientModel.address
    ]);
  }

  static Future<List<PatientModel>> getPatientData() async {
    List<Map<String, dynamic>> mapList =
        await database.rawQuery("select * from $patientTable");

    List<PatientModel> patientList = [];
    for (int i = 0; i < mapList.length; i++) {
      Map<String, dynamic> map = mapList[i];
      PatientModel patientModel = PatientModel.fromMap(map);
      patientList.add(patientModel);
    }
    return patientList;
  }

  static Future deletePatient(int Idno) async {
    await database.rawDelete("delete from $patientTable where $id=$Idno");
    print('Delete successfully');
  }

  static Future updatePatient(PatientModel patient) async {
    await database.rawUpdate(
        "update $patientTable set $name=?,$disease=?,$fees=?,$doctor=?,$address=? where $id=?",
        [
          patient.name,
          patient.disease,
          patient.fees,
          patient.doctor,
          patient.address,
          patient.id,
        ]);
    print('Update Patient Successfully');
  }

  static Future addDoctor(DoctorModel doctorModel) async {
    await database.rawInsert("insert into $doctorTable values(?,?,?,?,?,?)", [
      doctorModel.id,
      doctorModel.name,
      doctorModel.specialist,
      doctorModel.fees,
      doctorModel.timing,
      doctorModel.path,
    ]);
  }

  static Future<List<DoctorModel>> getDoctorData() async {
    List<Map<String, dynamic>> mapList =
        await database.rawQuery("select * from $doctorTable");

    List<DoctorModel> doctorList = [];
    for (int i = 0; i < mapList.length; i++) {
      Map<String, dynamic> map = mapList[i];
      DoctorModel doctorModel = DoctorModel.fromMap(map);
      doctorList.add(doctorModel);
    }
    return doctorList;
  }

  static Future deleteDoctor(int Idno) async {
    await database.rawDelete("delete from $doctorTable where $id=$Idno");
    print('Delete successfully');
  }

  static Future updateDoctor(DoctorModel doctor) async {
    await database.rawUpdate(
        "update $doctorTable set $name1=?,$specialist=?,$fees1=?,$timing=? ,$imPath=? where $id1=?",
        [
          doctor.name,
          doctor.specialist,
          doctor.fees,
          doctor.timing,
          doctor.path,
          doctor.id
        ]);
    print('Update Doctor Successfully');
  }

  static Future addCategory(CategoryModal categoryModal) async {
    await database.rawInsert("insert into $categoryTable values(?,?)",
        [categoryModal.id, categoryModal.category]);
    print('Add Successfully');
  }

  static Future<List<CategoryModal>> getCategoryData() async {
    List<Map<String, dynamic>> mapList =
        await database.rawQuery("select * from $categoryTable");

    List<CategoryModal> categoryList = [];
    for (int i = 0; i < mapList.length; i++) {
      Map<String, dynamic> map = mapList[i];
      CategoryModal categoryModal = CategoryModal.fromMap(map);
      categoryList.add(categoryModal);
    }
    return categoryList;
  }

  static Future deleteCategory(int IdNo) async {
    await database.rawDelete("delete from $categoryTable where $id=$IdNo");
    print('Delete successfully');
  }

  static Future updateCategory(CategoryModal categoryModal) async {
    await database.rawUpdate(
        "update $categoryTable set $category=? where $id2=?",
        [categoryModal.category, categoryModal.id]);
    print('Update Doctor Successfully');
  }
}
