import 'package:newlife_medicare/category/ui/add_category_screen.dart';
import 'package:newlife_medicare/category/ui/show_category_screen.dart';
import 'package:newlife_medicare/doctor/ui/add_doctor_screen.dart';
import 'package:newlife_medicare/doctor/ui/show_doctor_screen.dart';
import 'package:newlife_medicare/patient/ui/add_patient_screen.dart';
import 'package:newlife_medicare/patient/ui/show_patient_screen.dart';

final routesMap = {
  RouteConst.addPatient: (contex) {
    return AddPatientScreen();
  },
  RouteConst.showPatient: (context) {
    return ShowPatientScreen();
  },
  RouteConst.addDoctor: (context) {
    return AddDoctorScreen();
  },
  RouteConst.showDoctor: (context) {
    return ShowDoctorScreen();
  },
  RouteConst.addCategory: (context) {
    return AddCategoryScreen();
  },
  RouteConst.showCategory: (context) {
    return ShowCategoryScreen();
  }
};

class RouteConst {
  static const String addPatient = 'AddPatientScreen';
  static const String showPatient = 'ShowPatientScreen';
  static const String updatePatient = 'UpdatePatientScreen';
  static const String addDoctor = 'AddDoctorScreen';
  static const String showDoctor = 'ShowDoctorScreen';
  static const String updateDoctor = 'UpdateDoctorScreen';
  static const String addCategory = 'AddCategoryScreen';
  static const String showCategory = 'ShowCategoryScreen';
  static const String updateCategory = 'UpdateCategoryScreen';
}
