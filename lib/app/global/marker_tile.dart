import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MarKerTile extends GetView<HomeController> {
  const MarKerTile({
    Key? key,
    required this.date,
    required this.event,
    required this.colorList,
    required this.color,
  }) : super(key: key);

  final String date;
  final String event;
  final List colorList;
  final int color;

  @override
  Widget build(BuildContext context) {
    print('date: ${event}');
    print('colorList: ${colorList}');
    if (colorList.length == 1) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                offset: Offset(0, 4),
              )
            ],
            color: Color(colorList.first),
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(event),
            ],
          ),
        ),
      );
    } else if (colorList.length == 2) {
      return Stack(
        children: [
          Positioned(
            top: 15,
            left: 20,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[0]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Positioned(
            right: 20,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[1]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(event),
              ],
            ),
          ),
        ],
      );
    } else if(colorList.length == 3){
      return Stack(
        children: [
          Positioned(
            top: 17,
            left: 17,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[0]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Positioned(
            right: 23,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[1]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Positioned(
            left: 28,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[2]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(event),
              ],
            ),
          ),
        ],
      );
    }else if(colorList.length >= 4){
      return Stack(
        children: [
          Positioned(
            top: 23,
            left: 27,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[0]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Positioned(
            top: 23,
            right: 27,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[1]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Positioned(
            top: 2,
            left: 28,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[2]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Positioned(
            top: 2,
            right: 28,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Color(colorList[3]),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(event),
              ],
            ),
          ),
        ],
      );
    }else if(1 >= colorList.length){
      return Container();
    } else{
      return Container();
    }
  }
}
