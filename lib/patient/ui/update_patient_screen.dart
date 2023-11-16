import 'package:flutter/material.dart';
import 'package:newlife_medicare/doctor/database/patient_dp_helper.dart';
import 'package:newlife_medicare/patient/model/patient_model_class.dart';

class UpdatePatientScreen extends StatefulWidget {
  const UpdatePatientScreen({required this.patient, super.key});

  final PatientModel patient;

  @override
  State<UpdatePatientScreen> createState() => UpdatePatientScreenState();
}

class UpdatePatientScreenState extends State<UpdatePatientScreen> {
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController diseaseController;
  late TextEditingController feesController;
  late TextEditingController doctorController;
  late TextEditingController addressController;

  @override
  void initState() {
    PatientModel patientModel = widget.patient;
    nameController = TextEditingController(text: patientModel.name);
    idController = TextEditingController(
      text: patientModel.id.toString(),
    );
    diseaseController = TextEditingController(text: patientModel.disease);
    feesController = TextEditingController(
      text: patientModel.fees.toString(),
    );
    doctorController = TextEditingController(text: patientModel.doctor);
    addressController = TextEditingController(text: patientModel.address);
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
                        left: 60,
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
                Row(
                  children: [
                    const Text(
                      ' Id',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 85,
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
                Row(
                  children: [
                    const Text(
                      ' Disease',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 48,
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
                        left: 70,
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
                        left: 55,
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
                        left: 45,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      PatientModel patientModel = PatientModel(
                        name: nameController.text,
                        id: int.parse(idController.text),
                        disease: diseaseController.text,
                        fees: int.parse(feesController.text),
                        doctor: doctorController.text,
                        address: addressController.text,
                      );
                      await PatientDpHelper.updatePatient(patientModel);
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Update'),
                      ],
                    ),
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
