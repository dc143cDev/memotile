import 'package:flutter/material.dart';

//컬러, 테마의 관련된 정보와 코드를 적어놓는 말 그대로의 팔레트.
//모투미는 컬러 태그 시스템덕분에 ui가 알록달록함, 때문에 무채색-포인트컬러 스타일의 컬러 활용은 적합하지 않음.
//또한, 완전한 블랙/완전한 화이트는 가시성을 위해 자제해야함.

//공통
var memoTileText = Colors.grey[900];

//라이트모드
var backgroundLight = Color(0xfffffbff);
var subLight = Color(0xffe6dff9);
var iconLight = Color(0xff1d192b);
var shadowLight = Color(0xff000000).withOpacity(0.3);

//다크모드
var backgroundDark = Color(0xff1d1a1e);
var subDark = Color(0xff312e41);
var iconDark = Color(0xffe5dff9);
var secondTextDark = Color(0xffe5dff9);
var shadowDark = Color(0xff000000).withOpacity(0.6);
