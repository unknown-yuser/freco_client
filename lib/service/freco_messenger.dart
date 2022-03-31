import 'package:flutter/cupertino.dart';
import 'package:freco_client/service/freco_message.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:rxdart/rxdart.dart';
import 'freco_message.dart';

part "freco_client.dart";

class FReCoMessenger {
  // Workaround: this variable should be final. However, FReCoTestClient must be const and I could not find to avoid it.
  FReCoClient _client = _FReCoTestClient();
  FReCoMessenger({client}) {
    if (client != null) {
      _client = client;
    }
  }

  Stream<T> getMessageStream<T extends FReCoMessage>() {
    final messageId = getIdFromMessageType(T);
    if (messageId != null) {
      _client.subscribeMessage(messageId);
    }
    return _client.getMessageSubject().whereType<T>();
  }
}
