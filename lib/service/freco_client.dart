part of 'freco_messenger.dart';

abstract class FReCoClient {
  Subject<FReCoMessage> getMessageSubject();
}

class _FReCoTestClient implements FReCoClient {

  final _FReCoMessageWorker _worker = getFReCoMessageWorker();

  @override
  Subject<FReCoMessage> getMessageSubject() {
    return _worker.getMessageSubject();
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