import 'package:freco_client/service/freco_message.dart';
import 'basic.pb.dart';

// TODO: auto generate
const Map<Type, String> basicMessageMap = {Position: "position"};
FReCoMessage? generateBasicMessage(String id, dynamic src) {
  switch (id) {
    case "position":
      return Position.fromBuffer(src);
    default:
      return null;
  }
}