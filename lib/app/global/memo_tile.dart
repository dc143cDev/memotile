import 'package:flutter/material.dart';

class MemoTile extends StatelessWidget {
  const MemoTile({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text!,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
