import 'package:flutter/material.dart';

class CustomRadioWidget extends StatelessWidget {
  final String value;
  final String groupValue;
  final Function(dynamic) onChange;
  final String title;
  const CustomRadioWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChange,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          activeColor: Theme.of(context).colorScheme.primary,
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          groupValue: groupValue,
          onChanged: onChange,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
