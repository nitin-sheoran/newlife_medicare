class DoctorModel {
  int id;
  String name;
  String specialist;
  int fees;
  int timing;
  String path;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialist,
    required this.fees,
    required this.timing,
    this.path = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Specialist': specialist,
      'Fees': fees,
      'Timing': timing,
      'Path': path,
    };
  }

  static DoctorModel fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['Id'],
      name: map['Name'],
      specialist: map['Specialist'],
      fees: map['Fees'],
      timing: map['Timing'],
      path: map['Path'],
    );
  }
}
