import 'package:freco_client/service/messages/basic.pb.dart';
import 'package:protobuf/protobuf.dart' as $pb;

typedef FReCoMessage = $pb.GeneratedMessage;

// TODO: 全体的に build_runner で作成できるようにする
FReCoMessage? generateMessage(String id, dynamic src) {
  switch(id) {
    case "position":
      return Position.fromBuffer(src);
    default:
      return null;
  }
}

Map<Type, String> typeIdMap = {
  Position: "position"
};

String? getIdFromMessageType(Type type) {
  return typeIdMap[type];
}