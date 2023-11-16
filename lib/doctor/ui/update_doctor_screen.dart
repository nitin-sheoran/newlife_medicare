import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newlife_medicare/doctor/database/patient_dp_helper.dart';
import 'package:newlife_medicare/doctor/model/doctor_model_class.dart';
import 'package:newlife_medicare/doctor/util/String_const.dart';

class UpdateDoctorScreen extends StatefulWidget {
  const UpdateDoctorScreen({required this.doctor, super.key});

  final DoctorModel doctor;

  @override
  State<UpdateDoctorScreen> createState() => _UpdateDoctorScreenState();
}

class _UpdateDoctorScreenState extends State<UpdateDoctorScreen> {
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController specialistController;
  late TextEditingController feesController;
  late TextEditingController timingController;
  String? path;

  @override
  void initState() {
    DoctorModel doctorModel = widget.doctor;
    idController = TextEditingController(text: doctorModel.id.toString());
    nameController = TextEditingController(text: doctorModel.name);
    specialistController = TextEditingController(text: doctorModel.specialist);
    feesController = TextEditingController(text: doctorModel.fees.toString());
    timingController =
        TextEditingController(text: doctorModel.timing.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConst.tittleText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    StringConst.textId,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 70,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: idController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: StringConst.hintIdText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  const Text(
                    StringConst.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 45,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: StringConst.hintNameText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  const Text(
                    StringConst.specialist,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                        controller: specialistController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: StringConst.hintSpecialistText,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  const Text(
                    StringConst.fees,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 45,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: feesController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: StringConst.hintFeesText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  const Text(
                    StringConst.timing,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                        keyboardType: TextInputType.number,
                        controller: timingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: StringConst.hintTimingText,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              ElevatedButton(
                onPressed: () async {
                  await updateDoctor(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringConst.elevatedUpdateText),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (path != null)
                SizedBox(
                  width: 32,
                  height: 50,
                  child: Image.file(File(path!)),
                ),
              ElevatedButton(
                onPressed: () async {
                  await updateImage();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringConst.updateImageText),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> updateDoctor(BuildContext context) async {
    DoctorModel doctor = DoctorModel(
        id: int.parse(idController.text),
        name: nameController.text,
        specialist: specialistController.text,
        fees: int.parse(
          feesController.text,
        ),
        timing: int.parse(timingController.text),
        path: path ?? '');
    await PatientDpHelper.updateDoctor(doctor);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> updateImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    path = xFile!.path;
    setState(() {});
  }
}
