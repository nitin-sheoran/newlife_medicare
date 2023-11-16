import 'package:flutter/material.dart';
import 'package:newlife_medicare/doctor/database/patient_dp_helper.dart';
import 'package:newlife_medicare/patient/model/patient_model_class.dart';
import 'package:newlife_medicare/patient/ui/update_patient_screen.dart';

class ShowPatientScreen extends StatefulWidget {
  const ShowPatientScreen({super.key});

  @override
  State<ShowPatientScreen> createState() => _ShowPatientScreenState();
}

class _ShowPatientScreenState extends State<ShowPatientScreen> {
  List<PatientModel> patientList = [];

  @override
  void initState() {
    showPatientData();
    super.initState();
  }

  Future showPatientData() async {
    patientList = await PatientDpHelper.getPatientData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: (patientList.length),
          itemBuilder: (context, index) {
            PatientModel patientModel = patientList[index];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Text(
                        patientModel.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete '),
                                  content:
                                      const Text('Are you sure you delete it'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await PatientDpHelper.deletePatient(
                                            patientModel.id);
                                        showPatientData();
                                        if (mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UpdatePatientScreen(patient: patientModel);
                          }));
                          showPatientData();
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Id',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      Text(
                        patientModel.id.toString(),
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
                        'Disease',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Text(
                        patientModel.disease,
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
                        'Fees',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 90,
                      ),
                      Text(
                        patientModel.fees.toString(),
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
                        'Doctor',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                      Text(
                        patientModel.doctor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 55,
                      ),
                      Text(
                        patientModel.address,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
