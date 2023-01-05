import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

List<String> list = <String>['Entertainment', 'Travel', 'Food/Drink', 'Other'];

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String dropDownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: DropdownButton<String>(
          alignment: AlignmentDirectional.bottomCenter,
          value: dropDownValue,
          hint: const Text('Category'),
          items: list.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            },
          ).toList(),
          onChanged: (String? value) {
            setState(
              () {
                dropDownValue = value!;
              },
            );
          },
        ),
      ),
    );
  }
}
