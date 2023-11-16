class PatientModel {
  String name;
  int id;
  String disease;
  int fees;
  String doctor;
  String address;

  PatientModel({
    required this.name,
    required this.id,
    required this.disease,
    required this.fees,
    required this.doctor,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Id': id,
      'Disease': disease,
      'Fees': fees,
      'Doctor': doctor,
      'Address': address,
    };
  }

  static PatientModel fromMap(Map<String, dynamic> map) {
    return PatientModel(
      name: map['Name'],
      id: map['Id'],
      disease: map['Disease'],
      fees: map['Fees'],
      doctor: map['Doctor'],
      address: map['Address'],
    );
  }
}
