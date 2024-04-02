import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_app/text_field_widget.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> postData() async {
    const url =
        'https://mosquito-data-croudsourcing.onrender.com/report/submit';
    final Map<String, dynamic> data = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': numberController.text,
      'gender': gender,
      'age': ageController.text,
      'symptoms': '[\'cough\',\'cold\']',
      'address': ''
    };
    final headers = {'Content-Type': 'application/json'}; // Headers
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void submit() async {
    if (formKey.currentState?.validate() ?? true) {
      if (villageController.text.isEmpty ||
          districtController.text.isEmpty ||
          stateController.text.isEmpty ||
          pincodeController.text.isEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Please fill Address')));
        return;
      }
      if (gender?.isEmpty ?? true) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Select Gender')));
        return;
      }
      await postData();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Submitted')));
    }
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final ageController = TextEditingController();
  final villageController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  String? gender;
  bool address = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldWidget(
                icon: const Icon(Icons.person_2_sharp),
                title: 'Name',
                controller: nameController,
                type: TextInputType.name,
              ),
              TextFieldWidget(
                icon: const Icon(Icons.email_sharp),
                title: 'Email',
                controller: emailController,
                type: TextInputType.emailAddress,
              ),
              TextFieldWidget(
                icon: const Icon(Icons.phone_android_sharp),
                title: 'Phone Number',
                controller: numberController,
                type: TextInputType.phone,
              ),
              Card(
                elevation: 8,
                color: Theme.of(context).colorScheme.onPrimary,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Gender : ',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      Expanded(
                        child: DropdownButton(
                          value: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                                value: 'male', child: Text('Male')),
                            DropdownMenuItem(
                                value: 'female', child: Text('Female')),
                            DropdownMenuItem(
                                value: 'others', child: Text('Others')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextFieldWidget(
                icon: const Icon(Icons.percent),
                title: 'Age',
                controller: ageController,
                type: TextInputType.number,
              ),
              Card(
                elevation: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Text(
                      'Address : ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    title: const Icon(Icons.arrow_drop_down_circle_sharp),
                    onTap: () {
                      setState(() {
                        address = !address;
                      });
                    },
                  ),
                ),
              ),
              address
                  ? Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Card(
                        child: Column(
                          children: [
                            TextFieldWidget(
                              title: 'Village/Town',
                              icon: const Icon(Icons.home_mini),
                              controller: villageController,
                              type: TextInputType.name,
                            ),
                            TextFieldWidget(
                                icon: const Icon(Icons.location_city_sharp),
                                title: 'District',
                                controller: districtController,
                                type: TextInputType.streetAddress),
                            TextFieldWidget(
                                icon: const Icon(Icons.satellite),
                                title: 'State',
                                controller: stateController,
                                type: TextInputType.streetAddress),
                            TextFieldWidget(
                                icon: const Icon(Icons.pin_drop),
                                title: 'Pin Code',
                                controller: pincodeController,
                                type: TextInputType.streetAddress)
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 6,
                    ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: submit,
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
