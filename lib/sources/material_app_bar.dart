import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MaterialAppBar extends StatefulWidget {
  const MaterialAppBar({Key? key}) : super(key: key);

  @override
  State<MaterialAppBar> createState() {
    return _MaterialAppBar();
  }
}

class _MaterialAppBar extends State<MaterialAppBar> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _speedHasError = false;

  final speedOptions = ['above 40 km/h', 'below 40 km/h', '0 km/h'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
          debugPrint(_formKey.currentState!.value.toString());
        },
        autovalidateMode: AutovalidateMode.disabled,
        skipDisabled: true,
        child: Column(
          children: <Widget>[
            buildFormTitle(),
            buildTextRow('Please provide the speed of vehicle?'),
            buildDescription('please select one option given below'),
            FormBuilderRadioGroup<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              initialValue: null,
              name: 'radioSpeed',
              onChanged: _onChanged,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()]),
              options: speedOptions
                  .map((speed) => FormBuilderFieldOption(
                        value: speed,
                        child: Text(speed),
                      ))
                  .toList(growable: false),
              controlAffinity: ControlAffinity.leading,
              orientation: OptionsOrientation.vertical,
            ),
            buildTextRow('Enter remarks'),
            const SizedBox(height: 8),
            FormBuilderTextField(
              name: 'remarks',
              decoration: const InputDecoration(
                hintText: 'Enter your remarks',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 225, 225, 225),
              ),
            ),
            const SizedBox(height: 15),
            buildTextRow('Please provide the high speed of vehicle?'),
            buildDescription('please select one option given below'),
            const SizedBox(height: 10),
            FormBuilderDropdown<String>(
              name: 'dropDownSpeed',
              decoration: InputDecoration(
                suffix: _speedHasError
                    ? const Icon(Icons.error)
                    : const Icon(Icons.check),
                hintText: 'Select option',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()]),
              items: speedOptions
                  .map((speed) => DropdownMenuItem(
                        value: speed,
                        child: Text(speed),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _speedHasError = !(_formKey
                          .currentState?.fields['dropDownSpeed']
                          ?.validate() ??
                      false);
                });
              },
              valueTransformer: (val) => val?.toString(),
            ),
            const SizedBox(height: 15),
            buildTextRow('Please provide the speed of vehicle past 1 hour?'),
            buildDescription('please select one or more options given below'),
            FormBuilderCheckboxGroup<String>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              name: 'speedPast1Hour',
              options: const [
                FormBuilderFieldOption(value: '20 km/h'),
                FormBuilderFieldOption(value: '30 km/h'),
                FormBuilderFieldOption(value: '40 km/h'),
                FormBuilderFieldOption(value: '50 km/h'),
                FormBuilderFieldOption(value: '60 km/h'),
              ],
              onChanged: _onChanged,
              orientation: OptionsOrientation.vertical,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        debugPrint(_formKey.currentState?.value.toString());
                      } else {
                        debugPrint('Validation failed');
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildFormTitle() {
  return const Column(
    children: <Widget>[
      Text(
        'Form Title',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'description',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}

Widget buildTextRow(String text) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}

Widget buildDescription(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    ),
  );
}
