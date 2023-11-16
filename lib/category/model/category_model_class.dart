class CategoryModal {
  int id;
  String category;

  CategoryModal({
    required this.id,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Category': category,
    };
  }

  static CategoryModal fromMap(Map<String, dynamic> map) {
    return CategoryModal(
      id: map['Id'],
      category: map['Category'],
    );
  }
}
