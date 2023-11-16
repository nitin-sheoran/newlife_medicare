import 'package:flutter/material.dart';
import 'package:newlife_medicare/category/model/category_model_class.dart';
import 'package:newlife_medicare/doctor/database/patient_dp_helper.dart';
import 'package:newlife_medicare/doctor/util/String_const.dart';

import 'update_category_screen.dart';

class ShowCategoryScreen extends StatefulWidget {
  const ShowCategoryScreen({super.key});

  @override
  State<ShowCategoryScreen> createState() => _ShowCategoryScreenState();
}

class _ShowCategoryScreenState extends State<ShowCategoryScreen> {
  List<CategoryModal> categoryList = [];

  @override
  void initState() {
    showCategoryData();
    super.initState();
  }

  Future showCategoryData() async {
    categoryList = await PatientDpHelper.getCategoryData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            CategoryModal categoryModal = categoryList[index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        StringConst.categoryIdText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 220,
                      ),
                      Text(
                        categoryModal.id.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
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
                                        await PatientDpHelper.deleteCategory(
                                            categoryModal.id);
                                        showCategoryData();
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
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UpdateCategoryScreen(
                                category: categoryModal);
                          }));
                          showCategoryData();
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        StringConst.categoryHintTextCategory,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        categoryModal.category,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
