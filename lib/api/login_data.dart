import 'dart:convert';
import 'package:http/http.dart' as http;

class Address {
  final String villageOrTown;
  final String district;
  final String state;
  final String country;
  final String pincode;
  final double? latitude;
  final double? longitude;

  const Address(
      {required this.villageOrTown,
      required this.district,
      required this.state,
      required this.country,
      required this.pincode,
      this.latitude,
      this.longitude});
}

class LoginData {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String age;
  final List<String> symptoms;
  final String status;
  final String? diagnosedWith;
  final DateTime? dateOfDiagnosis;
  final Address address;

  const LoginData(
      {required this.name,
      required this.email,
      required this.phone,
      required this.gender,
      required this.age,
      required this.symptoms,
      required this.status,
      required this.diagnosedWith,
      required this.dateOfDiagnosis,
      required this.address});
}

Future<void> sendData(LoginData obj) async {
  String symptomsStr = obj.symptoms.join(',');
  Map<String, dynamic> map = {
    'name': obj.name,
    'email': obj.email,
    'phone': obj.phone,
    'gender': obj.gender,
    'age': obj.age,
    'symptoms': symptomsStr,
    'status': obj.status,
    'address': <String, dynamic>{
      'villageOrTown': obj.address.villageOrTown,
      'district': obj.address.district,
      'state': obj.address.state,
      'country': obj.address.country,
      'latitude': obj.address.latitude,
      'longitude': obj.address.latitude
    }
  };
  if (obj.status == 'diagnosed') {
    map['diagnosedWith'] = obj.diagnosedWith!;
    map['dateOfDiagnosis'] = obj.dateOfDiagnosis!;
    map['reportUrl'] = 'File link';
  }
  final response = await http.post(
      Uri.parse(
          'https://mosquito-data-croudsourcing.onrender.com/report/submit'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(map));
  print(response.statusCode);
}
