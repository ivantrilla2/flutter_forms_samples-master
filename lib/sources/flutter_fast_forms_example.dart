import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';

class FlutterFastFormsExample extends StatelessWidget {
  const FlutterFastFormsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _FlutterFastFormsExample();
  }
}

class _FlutterFastFormsExample extends StatelessWidget {
  _FlutterFastFormsExample({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FastForm(
                formKey: formKey,
                inputDecorationTheme: InputDecorationTheme(
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[500]!, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                children: _buildForm(context),
                onChanged: (value) {
                  // ignore: avoid_print
                  print('Form changed: ${value.toString()}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildForm(BuildContext context) {
  return [
    FastFormSection(
      padding: const EdgeInsets.all(16.0),
      header: const Padding(
        padding: EdgeInsets.all(1.0),
        child: Text(
          'Form Example Section',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      children: [
        FastAutocomplete<String>(
          name: 'autocomplete',
          labelText: 'Autocomplete',
          options: const ['Alaska', 'Ivan', 'Salesians', 'S2AM'],
        ),
        FastDatePicker(
          name: 'date_picker',
          labelText: 'Date Picker',
          firstDate: DateTime(1970),
          lastDate: DateTime(2040),
        ),
        FastDateRangePicker(
          name: 'date_range_picker',
          labelText: 'Date Range Picker',
          firstDate: DateTime(1970),
          lastDate: DateTime(2040),
        ),
        const FastTimePicker(
          name: 'time_picker',
          labelText: 'Time Picker',
        ),
        const FastChipsInput(
          name: 'input_chips',
          labelText: 'Input Chips',
          options: ['Angular', 'React', 'Vue', 'Svelte', 'Flutter'],
          initialValue: [
            'HTML',
            'CSS',
            'React',
            'Dart',
            'TypeScript',
            'Angular',
          ],
          runSpacing: 13.0,
        ),
        FastChoiceChips(
          name: 'choice_chips',
          labelText: 'Choice Chips',
          alignment: WrapAlignment.center,
          chipPadding: const EdgeInsets.all(8.0),
          chips: [
            FastChoiceChip(
              avatar: const FlutterLogo(),
              selected: true,
              value: 'Flutter',
            ),
            FastChoiceChip(
              avatar: const Icon(Icons.android_sharp, size: 16.0),
              value: 'Android',
            ),
            FastChoiceChip(
              selected: true,
              value: 'Chrome OS',
            ),
          ],
        ),
        const FastSwitch(
          name: 'switch',
          labelText: 'Switch',
          titleText: 'This is a switch',
          contentPadding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
        ),
        FastTextField(
          name: 'text_field',
          labelText: 'Text Field',
          placeholder: 'MM/JJJJ',
          keyboardType: TextInputType.datetime,
          maxLength: 7,
          prefix: const Icon(Icons.calendar_today),
          buildCounter: inputCounterWidgetBuilder,
          inputFormatters: const [],
          validator: Validators.compose([
            Validators.required((valor) => 'Field is required'),
            Validators.minLength(
                7,
                (valor, minLength) =>
                    'Field must contain at least $minLength characters')
          ]),
        ),
        const FastDropdown<String>(
          name: 'dropdown',
          labelText: 'Dropdown Field',
          items: ['Spain', 'France', 'Finland', 'Italy', 'Russia'],
          initialValue: 'Finland',
        ),
        FastRadioGroup<String>(
          name: 'radio_group',
          labelText: 'Radio Group Model',
          options: const [
            FastRadioOption(title: Text('Option 1'), value: 'option-1'),
            FastRadioOption(title: Text('Option 2'), value: 'option-2'),
            FastRadioOption(title: Text('Option 3'), value: 'option-3'),
          ],
        ),
      ],
    ),
  ];
}
