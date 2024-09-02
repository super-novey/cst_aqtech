import 'package:flutter/material.dart';

class BussinessDateField extends StatelessWidget {
  const BussinessDateField({super.key, required this.title});

  final String title;

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
        const TextField()
      ],
    );
  }
}
