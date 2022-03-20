import 'package:flutter/material.dart';
import 'package:freco_client/app/app.locator.dart';
import 'package:freco_client/app/app.router.dart';
import 'package:freco_client/ui/widget/style/colors.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupStackedLocator(environment: Environment.dev);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Robot Controller',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      theme: ThemeData(
        primarySwatch: ColorStyle.primaryColor
      ),
    );
  }
}

