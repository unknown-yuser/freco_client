import 'package:freco_client/service/freco_message.dart';
import 'package:freco_client/service/messages/basic.pb.dart';
import 'package:stacked/stacked.dart';
import 'package:freco_client/service/freco_messenger.dart';

class ControllerPageViewModel extends BaseViewModel {

  final FReCoMessenger _frecoMessenger;
  late final Stream<Position> _positionMessage;

  int x = 0;
  int y = 0;

  ControllerPageViewModel() :_frecoMessenger = FReCoMessenger() {
    _positionMessage = _frecoMessenger.getMessageStream<Position>();
    _positionMessage.listen((event) {
      x = event.x;
      y = event.y;
      notifyListeners();
    });
  }
}