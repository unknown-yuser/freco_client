import 'package:flutter/material.dart';
import 'package:freco_client/app/app.locator.dart';
import 'package:freco_client/app/app.router.dart';
import 'package:freco_client/ui/page/robot_select_page/robot_select_viewmodel.dart';
import 'package:freco_client/ui/widget/component/FReCoPushButton.dart';
import 'package:freco_client/ui/widget/style/colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RobotSelectPage extends StatelessWidget {
  const RobotSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService =  stackedLocator<NavigationService>();
    final textEditingController = TextEditingController();

    return ViewModelBuilder<RobotSelectViewModel>.reactive(
        viewModelBuilder: () => RobotSelectViewModel(), 
        builder: (context, viewModel, child) => Scaffold(
          backgroundColor: ColorStyle.backgroundColor,
          body: Center(
            child: SizedBox(
              width: 640,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Image(image: AssetImage("assets/images/icon_robot.jpeg")),
                  TextFormField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.settings_ethernet),
                      hintText: "Set ipaddress",
                      labelText: "ip address"
                    ),
                  ),
                  FReCoPushButton(
                      onPressed: () {
                        viewModel.connect("dummy address",
                                ()=>{ _navigationService.navigateTo(Routes.controllerPage) },
                                ()=>{ /* TODO: notify connection error */ } );
                      },
                      label: "接続開始"
                  )
                ],
              )
            ),
          ),
        )
    );
  }
}