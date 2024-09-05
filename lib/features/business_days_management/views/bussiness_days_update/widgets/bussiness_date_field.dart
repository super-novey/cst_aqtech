import 'package:flutter/material.dart';

class BussinessDateField extends StatelessWidget {
  const BussinessDateField(
      {super.key, required this.title, required this.controller});

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              Theme.of(context).textTheme.bodyMedium!.apply(fontWeightDelta: 2),
        ),
        TextField(
          controller: controller,
        )
      ],
    );
  }
}
