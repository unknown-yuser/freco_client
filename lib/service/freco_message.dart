import 'package:protobuf/protobuf.dart' as $pb;
import 'freco_message_extension.dart';

typedef FReCoMessage = $pb.GeneratedMessage;

class FReCoMessageMap with FReCoMessageMapRegister {
  static final FReCoMessageMap _singleton = FReCoMessageMap._internal();
  static final Map<Type, String> _typeIdMap = {};

  factory FReCoMessageMap() {
    return _singleton;
  }

  FReCoMessageMap._internal() {
    register(_typeIdMap);
  }

  void appendMap(Map<Type, String> map) {
    _typeIdMap.addAll(map);
  }

  String? getIdFromType(Type type) => _typeIdMap[type];
}
