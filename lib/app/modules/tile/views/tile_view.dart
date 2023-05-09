import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tile_controller.dart';

class TileView extends GetView<TileController> {
  const TileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
