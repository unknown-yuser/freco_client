import 'package:freco_client/service/freco_message.dart';
import 'package:stacked/stacked.dart';
import 'package:freco_client/service/freco_messenger.dart';

class ControllerPageViewModel extends BaseViewModel {

  final FReCoMessenger _frecoMessenger;
  late final Stream<PositionMessage> _positionMessage;

  int x = 0;
  int y = 0;

  ControllerPageViewModel() :
        _frecoMessenger = FReCoMessenger() {
    _positionMessage = _frecoMessenger.getMessageStream<PositionMessage>();
    _positionMessage.listen((event) {
      x = event.x;
      y = event.y;
      notifyListeners();
    });
  }
}