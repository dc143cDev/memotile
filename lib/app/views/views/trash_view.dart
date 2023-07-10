import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TrashView extends GetView {
  const TrashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrashView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TrashView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
