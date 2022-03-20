import 'package:freco_client/ui/page/controller/controller_page.dart';
import 'package:freco_client/ui/page/robot_select_page/robot_select_page.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes:[
    MaterialRoute(page: RobotSelectPage, initial: true),
    MaterialRoute(page: ControllerPage)
  ],
  dependencies: [
    LazySingleton(classType: NavigationService, environments: {Environment.dev})
  ],
  locatorName: 'stackedLocator',
  locatorSetupName: 'setupStackedLocator'
)
class App {

}