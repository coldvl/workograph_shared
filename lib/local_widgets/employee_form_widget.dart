import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmployeeFormWidget extends StatelessWidget {
  final int? totalHours;
  final String? name;

  final ValueChanged<int> onChangedTotalHours;
  final ValueChanged<String> onChangedName;

  const EmployeeFormWidget({
    Key? key,
    this.totalHours = 0,
    this.name = '',
    required this.onChangedTotalHours,
    required this.onChangedName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildName(),
              buildTotalHours(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Name',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedName,
      );

  Widget buildTotalHours() => TextField(
        decoration: const InputDecoration(
          hintText: 'The sum of hours worked',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
        onChanged: (totalHours) => onChangedTotalHours(int.parse(totalHours)),
      );
}
