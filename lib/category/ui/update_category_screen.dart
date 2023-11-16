import 'package:flutter/material.dart';
import 'package:newlife_medicare/category/model/category_model_class.dart';
import 'package:newlife_medicare/doctor/database/patient_dp_helper.dart';
import 'package:newlife_medicare/doctor/util/String_const.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({required this.category, super.key});

  final CategoryModal category;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  late TextEditingController idController;
  late TextEditingController categoryController;

  @override
  void initState() {
    CategoryModal categoryModal = widget.category;
    idController = TextEditingController(
      text: categoryModal.id.toString(),
    );
    categoryController = TextEditingController(text: categoryModal.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Id',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 90,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: idController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: StringConst.categoryHintTextId,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    StringConst.categoryCategoryText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: StringConst.categoryHintTextCategory,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 62,
              ),
              ElevatedButton(
                onPressed: () async {
                  CategoryModal category = CategoryModal(
                      id: int.parse(idController.text),
                      category: categoryController.text);
                  await PatientDpHelper.updateCategory(category);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
