import 'package:freco_client/service/messages/basic.pb.dart';
import 'package:protobuf/protobuf.dart' as $pb;

typedef FReCoMessage = $pb.GeneratedMessage;

FReCoMessage generateMessage(String id, dynamic src) {
  return Position.fromBuffer(src);
}