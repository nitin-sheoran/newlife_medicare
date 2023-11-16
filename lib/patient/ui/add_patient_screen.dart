import 'package:flutter/material.dart';
import 'package:newlife_medicare/doctor/database/patient_dp_helper.dart';
import 'package:newlife_medicare/patient/model/patient_model_class.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController diseaseController;
  late TextEditingController feesController;
  late TextEditingController doctorController;
  late TextEditingController addressController;
String? path;
  @override
  void initState() {
    nameController = TextEditingController();
    idController = TextEditingController();
    diseaseController = TextEditingController();
    feesController = TextEditingController();
    doctorController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Patient Information'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      ' Name',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 50,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter Name'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const SizedBox(
                  width: 18,
                ),
                Row(
                  children: [
                    const Text(
                      ' Id',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 75,
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
                            hintText: 'Enter id'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const SizedBox(
                  width: 18,
                ),
                Row(
                  children: [
                    const Text(
                      ' Disease',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: diseaseController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter Disease'),
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
                      ' Fees',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 60,
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
                            hintText: 'Enter Fees'),
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
                      ' Doctor',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 50,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: doctorController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter Doctor'),
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
                      ' Address',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter Address'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),

                ElevatedButton(
                  onPressed: () async {
                    PatientModel patient = PatientModel(
                      name: nameController.text,
                      id: int.parse(idController.text),
                      disease: diseaseController.text,
                      fees: int.parse(feesController.text),
                      doctor: doctorController.text,
                      address: addressController.text,
                    );
                    await PatientDpHelper.addPatient(patient);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add'),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
