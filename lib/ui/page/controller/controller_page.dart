import 'package:flutter/material.dart';
import 'package:freco_client/ui/page/controller/controller_viewmodel.dart';
import 'package:freco_client/ui/widget/style/colors.dart';
import 'package:stacked/stacked.dart';

class ControllerPage extends StatelessWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ControllerPageViewModel>.reactive(
        viewModelBuilder: () => ControllerPageViewModel(),
        builder: (context, viewModel, child) => Scaffold(
          backgroundColor: ColorStyle.backgroundColor,
          body: Center(
            child: Column (
              children: <Widget>[
                Text("Position x:${viewModel.x} y:${viewModel.y}"),
              ],
            ),
          ),
        )
    );
  }
}