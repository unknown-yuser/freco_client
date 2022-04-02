import 'freco_message.dart';
import 'messages/basic.extension.dart';

mixin FReCoMessageMapRegister {
  void register(Map<Type, String> src) {
    src.addAll(basicMessageMap);
  }

  FReCoMessage? generateMessage(String id, dynamic src) {
    final FReCoMessage? message;
    message = generateBasicMessage(id, src);
    if (message != null) {
      return message;
    }
    return null;
  }
}