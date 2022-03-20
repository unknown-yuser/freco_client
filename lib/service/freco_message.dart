class FReCoMessage {}

class PositionMessage implements FReCoMessage {
  final int x;
  final int y;

  PositionMessage(this.x, this.y);
}

class MovingMessage implements FReCoMessage {
  final bool moving;
  MovingMessage(this.moving);
}