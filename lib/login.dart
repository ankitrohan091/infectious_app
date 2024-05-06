import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_app/api/login_data.dart';
import 'package:med_app/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      await sendData(LoginData(
        name: nameController.text,
        email: emailController.text,
        phone: numberController.text,
        age: ageController.text,
        gender: gender!,
        symptoms: [symptoms!],
        status: stateController.text,
        dateOfDiagnosis: dateOfDiagnosis,
        diagnosedWith: diagnosedWithController.text,
        address: Address(
            villageOrTown: villageController.text,
            district: districtController.text,
            state: stateController.text,
            country: 'India',
            pincode: pincodeController.text,
            latitude: 50,
            longitude: 100),
      ));
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
  final symptomsController = TextEditingController();
  final diagnosedWithController = TextEditingController();
  DateTime? dateOfDiagnosis;
  String? symptoms;
  String? status;
  String? gender;
  bool address = false;
  bool otherSymptoms = false;
  final formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
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
                color: Theme.of(context).colorScheme.onPrimary,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Symptoms: ',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      Expanded(
                        child: otherSymptoms
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    otherSymptoms = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        symptomsController.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(Icons.arrow_drop_down)
                                  ],
                                ))
                            : DropdownButton(
                                value: symptoms,
                                onChanged: (value) {
                                  if (value == 'others') {
                                    symptomsController.clear();
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Please specify the symptoms'),
                                            content: Form(
                                              key: _formKey,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value?.isEmpty ?? true) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.name,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller: symptomsController,
                                                maxLength: 20,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                decoration:
                                                    const InputDecoration(
                                                        counterText: ''),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    symptomsController.clear();
                                                  },
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(ctx);
                                                    setState(() {
                                                      otherSymptoms = true;
                                                    });
                                                  },
                                                  child: const Text('Okay')),
                                            ],
                                          );
                                        });
                                  } else {
                                    setState(() {
                                      symptoms = value;
                                    });
                                  }
                                },
                                alignment: Alignment.center,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'vomiting',
                                    child: Text('Vomiting'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'cough',
                                    child: Text('Cough'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'fever',
                                    child: Text('Fever'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'headache',
                                    child: Text('Headache'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'others',
                                    child: Text('Others'),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(
                            'Status : ',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ]),
                      Row(children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Diagnosed'),
                            value: 'diagnosed',
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ),
                      ]),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Not Diagnosed'),
                              value: 'not-diagnosed',
                              groupValue: status,
                              onChanged: (value) {
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              status == 'diagnosed'
                  ? Column(
                      children: [
                        TextFieldWidget(
                            icon: null,
                            title: 'Diagnosed With',
                            controller: diagnosedWithController,
                            type: TextInputType.name),
                        Card(
                          elevation: 8,
                          color: Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.calendar_month_sharp,
                                  ),
                                  style: IconButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                  onPressed: () async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2000),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime(2100, 12, 31));
                                    setState(() {
                                      dateOfDiagnosis = date!;
                                    });
                                  }),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                dateOfDiagnosis == null
                                    ? 'Pick a date'
                                    : DateFormat('yyyy-MM-dd')
                                        .format(dateOfDiagnosis!),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              leading: Text(
                                'Address : ',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              title: const Icon(
                                  Icons.arrow_drop_down_circle_sharp),
                              onTap: () {
                                setState(() {
                                  address = !address;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
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
              Card(
                  elevation: 8,
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: const Row(
                    children: [
                      Text('Upload Report'),
                    ],
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  submit();
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Submitted')));
                },
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
