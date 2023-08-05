import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LocaleView extends GetView {
  const LocaleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LocaleView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LocaleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
