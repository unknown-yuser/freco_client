// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/page/controller/controller_page.dart';
import '../ui/page/robot_select_page/robot_select_page.dart';

class Routes {
  static const String robotSelectPage = '/';
  static const String controllerPage = '/controller-page';
  static const all = <String>{
    robotSelectPage,
    controllerPage,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.robotSelectPage, page: RobotSelectPage),
    RouteDef(Routes.controllerPage, page: ControllerPage),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    RobotSelectPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RobotSelectPage(),
        settings: data,
      );
    },
    ControllerPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ControllerPage(),
        settings: data,
      );
    },
  };
}
