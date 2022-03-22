import 'package:flutter_test/flutter_test.dart';
import 'package:freco_client/service/freco_message.dart';
import 'package:freco_client/service/freco_messenger.dart';

void main() {
  testWidgets('test', (WidgetTester tester) async {
    var messenger = FReCoMessenger();
    var observable = messenger.getMessageStream<PositionMessage>();
    observable.listen((event) {
      print("get position message");
    });

    var worker = getFReCoMessageWorker();
    print("add position message");
    worker.addMessage(PositionMessage(1, 1));
    print("add moving message");
    worker.addMessage(MovingMessage(true));

    print("end test");
  });
}