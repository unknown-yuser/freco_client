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
