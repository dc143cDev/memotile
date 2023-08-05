import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InfoView extends GetView {
  const InfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
