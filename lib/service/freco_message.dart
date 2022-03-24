class FReCoMessageFactory {
  static FReCoMessage createMessage(String messageId, String value) {
    // TODO:pt = "{x},{y}" として入っているものとする。フォーマットを決める。
    // TODO: topic から message を作成する仕組みを作る
    if (messageId == "position") {
      final values = value.split(",");
      return PositionMessage(int.parse(values[0]), int.parse(values[1]));
    }

    throw UnsupportedError("$messageId is not supported");
  }
}

abstract class FReCoMessage {}

class PositionMessage implements FReCoMessage {
  final int x;
  final int y;

  static String messageId = "position";

  PositionMessage(this.x, this.y);
}

class MovingMessage implements FReCoMessage {
  final bool moving;

  static String messageId = "moving";

  MovingMessage(this.moving);
}
