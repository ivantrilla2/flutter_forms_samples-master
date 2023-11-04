import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FlutterStepperSample extends StatefulWidget {
  const FlutterStepperSample({Key? key}) : super(key: key);

  @override
  State<FlutterStepperSample> createState() {
    return _FlutterStepperSample();
  }
}

class _FlutterStepperSample extends State<FlutterStepperSample> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  int comptador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        initialValue: const {
          'correuElectronic': '',
          'adreca': '',
          'telefon': '',
          'nom': '',
          'cognoms': '',
        },
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: comptador,
                steps: [
                  Step(
                    state:
                        comptador <= 0 ? StepState.editing : StepState.complete,
                    isActive: comptador >= 0,
                    title: const Text('Personal'),
                    content: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: FormBuilderTextField(
                            name: 'correuElectronic',
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: FormBuilderTextField(
                            name: 'adreca',
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              alignLabelWithHint: true,
                              prefixIcon: Icon(Icons.home),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            maxLines: 4,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: FormBuilderTextField(
                            name: 'telefon',
                            decoration: const InputDecoration(
                              labelText: 'Mobile No',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    state:
                        comptador <= 1 ? StepState.editing : StepState.complete,
                    isActive: comptador >= 1,
                    title: const Text('Contact'),
                    content: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: FormBuilderTextField(
                            name: 'nom',
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: FormBuilderTextField(
                            name: 'cognoms',
                            decoration: const InputDecoration(
                              labelText: 'Last Names',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    state: StepState.complete,
                    isActive: comptador >= 2,
                    title: const Text('Upload'),
                    content: Column(
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                title: const Text('Email'),
                                subtitle: Text(_formKey.currentState
                                        ?.fields['correuElectronic']?.value ??
                                    ''),
                              ),
                              const Divider(),
                              ListTile(
                                title: const Text('Address'),
                                subtitle: Text(_formKey.currentState
                                        ?.fields['adreca']?.value ??
                                    ''),
                              ),
                              const Divider(),
                              ListTile(
                                title: const Text('Mobile No'),
                                subtitle: Text(_formKey.currentState
                                        ?.fields['telefon']?.value ??
                                    ''),
                              ),
                              const Divider(),
                              ListTile(
                                title: const Text('Name'),
                                subtitle: Text(_formKey
                                        .currentState?.fields['nom']?.value ??
                                    ''),
                              ),
                              const Divider(),
                              ListTile(
                                title: const Text('Last Names'),
                                subtitle: Text(_formKey.currentState
                                        ?.fields['cognoms']?.value ??
                                    ''),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onStepContinue: () {
                  if (comptador < 2) {
                    setState(() {
                      comptador += 1;
                    });
                  } else {
                    if (_formKey.currentState!.saveAndValidate()) {
                      // ignore: avoid_print
                      print('Submitted');
                    }
                  }
                },
                onStepCancel: () {
                  if (comptador == 0) {
                    return;
                  }
                  setState(() {
                    comptador -= 1;
                  });
                },
                onStepTapped: (int index) {
                  setState(() {
                    comptador = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
