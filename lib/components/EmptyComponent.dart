import 'package:flutter/material.dart';

class EmptyComponent extends StatelessWidget {
  const EmptyComponent({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25.0,
        ),
        SizedBox(
          width: 100,
          height: 100,
          child:
              Image.asset("assets/images/empty_box.png", fit: BoxFit.contain),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          title ?? "Kosong !",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
