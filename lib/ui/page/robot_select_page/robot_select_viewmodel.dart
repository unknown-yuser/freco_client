import 'package:stacked/stacked.dart';

class RobotSelectViewModel extends BaseViewModel {
  RobotSelectViewModel() {}

  void connect(String ipaddress, Function onSuccess, Function onFailed) {
    // TODO: pass ipaddress and check connection.
    onSuccess();
  }
}
