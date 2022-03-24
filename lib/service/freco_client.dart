part of 'freco_messenger.dart';

abstract class FReCoClient {
  Subject<FReCoMessage> getMessageSubject();
  Future subscribeMessage(String messageId);
}

class _FReCoTestClient implements FReCoClient {
  final _FReCoMessageWorker _worker = getFReCoMessageWorker();
  final _mqttClient = FReCoMqttClient();
  
  @override
  Future subscribeMessage(String messageId) async {
    _mqttClient.subscribe(messageId);
  }

  @override
  Subject<FReCoMessage> getMessageSubject() {
    return _worker.getMessageSubject();
  }
}

// TODO: eclipse-mosquitto で動作確認している。他のbrokerでは試していない
@visibleForTesting
class FReCoMqttClient {
  final _FReCoMessageWorker _worker = getFReCoMessageWorker();
  final MqttClient _client = MqttServerClient.withPort("localhost", "", 1883 /* mosquitto の デフォルトのポート番号*/ );

  Future<bool> subscribe(String topic) async {
    if (await _connectToClient() == true) {
      _subscribe(topic);
    }
    return true;
  }

  Future<bool> _connectToClient() async {
    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      debugPrint("すでに接続しています。");
      return true;
    }
    return _login();
  }

  void _onDisconnected() {
    debugPrint("切断します。${_client.connectionStatus?.returnCode}");
    _client.disconnect();
  }

  void _onConnected() {
    debugPrint("接続しました。");
  }

  void _onSubscribed(String topic) {
    debugPrint("$topic を購読します。");
  }

  Future _subscribe(String topic) async {
    _client.subscribe(topic, MqttQos.atMostOnce);

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final String payloadMessage =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _worker.addMessage(FReCoMessageFactory.createMessage(topic, payloadMessage));
    });
  }

  Future<bool> _login() async {
    _client.setProtocolV311();
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = _onDisconnected;
    _client.onConnected = _onConnected;
    _client.onSubscribed = _onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier("mqtt_uniqueId")
        .withWillTopic("willTopic")
        .withWillMessage("willMessage")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMess;

    try {
      await _client.connect();
    } on Exception catch (e) {
      debugPrint('接続に失敗しました - $e');
      _client.disconnect();
      return false;
    }

    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      debugPrint('接続に失敗しました。 接続状態:${_client.connectionStatus}');
      _client.disconnect();
      return false;
    }
    return true;
  }
}

@visibleForTesting
_FReCoMessageWorker getFReCoMessageWorker() {
  return _FReCoMessageWorker();
}

class _FReCoMessageWorker {
  static final _FReCoMessageWorker _worker = _FReCoMessageWorker._internal();
  static final Subject<FReCoMessage> _message = PublishSubject<FReCoMessage>();

  _FReCoMessageWorker._internal();

  factory _FReCoMessageWorker() {
    return _worker;
  }

  Subject<FReCoMessage> getMessageSubject() {
    return _message;
  }

  addMessage(FReCoMessage message) {
    _message.add(message);
  }
}
