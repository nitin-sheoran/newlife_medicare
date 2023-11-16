import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newlife_medicare/category/model/category_model_class.dart';
import 'package:newlife_medicare/doctor/database/patient_dp_helper.dart';
import 'package:newlife_medicare/doctor/model/doctor_model_class.dart';
import 'package:newlife_medicare/doctor/util/String_const.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController specialistController;
  late TextEditingController feesController;
  late TextEditingController timingController;
  String? path;
  late List<CategoryModal> categoriesList;
  String? selectedCategory;

  @override
  void initState() {
    idController = TextEditingController();
    nameController = TextEditingController();
    specialistController = TextEditingController();
    feesController = TextEditingController();
    timingController = TextEditingController();
    categoriesList = [];
    loadCategories();
    super.initState();
  }

  Future loadCategories() async {
    categoriesList = await PatientDpHelper.getCategoryData();
    selectedCategory = categoriesList[0].category;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> dropDownMenuList = [];
    for (var category in categoriesList) {
      dropDownMenuList.add(DropdownMenuItem(
          value: category.category, child: Text(category.category)));
    }

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
                    StringConst.id,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 43,
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  if (selectedCategory != null && dropDownMenuList.isNotEmpty)
                    DropdownButton(
                      items: dropDownMenuList,
                      onChanged: (value) {
                        selectedCategory = value;
                        setState(() {});
                      },
                      value: selectedCategory,
                    )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  const Text(
                    StringConst.fees,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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
                    StringConst.timing,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 25,
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
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              ElevatedButton(
                onPressed: () async {
                  await addDoctor(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConst.elevatedText,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              if (path != null)
                SizedBox(
                  width: 32,
                  height: 50,
                  child: Image.file(
                    File(path!),
                  ),
                ),
              ElevatedButton(
                onPressed: () async {
                  await pickImage();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConst.elevatedImageText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    path = xFile!.path;
    setState(() {});
  }

  Future<void> addDoctor(BuildContext context) async {
    DoctorModel doctor = DoctorModel(
        id: int.parse(idController.text),
        name: nameController.text,
        specialist: selectedCategory!,
        fees: int.parse(
          feesController.text,
        ),
        timing: int.parse(timingController.text),
        path: path ?? '');
    await PatientDpHelper.addDoctor(doctor);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
