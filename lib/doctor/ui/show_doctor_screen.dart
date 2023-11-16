import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newlife_medicare/doctor/database/patient_dp_helper.dart';
import 'package:newlife_medicare/doctor/model/doctor_model_class.dart';
import 'package:newlife_medicare/doctor/ui/update_doctor_screen.dart';
import 'package:newlife_medicare/doctor/util/String_const.dart';

class ShowDoctorScreen extends StatefulWidget {
  const ShowDoctorScreen({super.key});

  @override
  State<ShowDoctorScreen> createState() => _ShowDoctorScreenState();
}

class _ShowDoctorScreenState extends State<ShowDoctorScreen> {
  List<DoctorModel> doctorList = [];

  @override
  void initState() {
    showDoctorData();
    super.initState();
  }

  Future showDoctorData() async {
    doctorList = await PatientDpHelper.getDoctorData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: (doctorList.length),
            itemBuilder: (context, index) {
              DoctorModel doctorModel = doctorList[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          StringConst.textId,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 130,
                        ),
                        Text(
                          doctorModel.id.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            deleteData(context, doctorModel);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await updateData(context, doctorModel);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          StringConst.textName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 90,
                        ),
                        Text(
                          doctorModel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          StringConst.textSpecialist,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          doctorModel.specialist,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          StringConst.textFees,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Text(
                          doctorModel.fees.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          StringConst.textTiming,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 95,
                        ),
                        Text(
                          doctorModel.timing.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    if (doctorModel.path.isNotEmpty)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: Image.file(
                          File(doctorModel.path),
                        ),
                      ),
                    const Divider(),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<void> updateData(BuildContext context, DoctorModel doctorModel) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateDoctorScreen(doctor: doctorModel);
    }));
    showDoctorData();
  }

  void deleteData(BuildContext context, DoctorModel doctorModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete '),
            content: const Text('Are you sure you delete it'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await PatientDpHelper.deleteDoctor(doctorModel.id);
                  showDoctorData();
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Delete'),
              ),
            ],
          );
        });
  }
}
