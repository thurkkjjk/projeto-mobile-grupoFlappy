import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game.dart';
import '../variables.dart';
import 'package:flappy_bird/components/bird_movement.dart';

class Bird extends SpriteGroupComponent<BirdMovement> with CollisionCallbacks {
  Bird()
    : super(
        position: Vector2(birdStartX, birdStartY),
        size: Vector2(birdWidth, birdHeigth),
      );

  double velocity = 0;

  @override
  FutureOr<void> onLoad() async {
    final birdMid = await Sprite.load('birdMid.png');
    final birdUp = await Sprite.load('birdUp.png');
    final birdDown = await Sprite.load('birdDown.png');
    sprites = {
      BirdMovement.middle: birdMid,
      BirdMovement.up: birdUp,
      BirdMovement.down: birdDown,
    };
    current = BirdMovement.middle;
    add(CircleHitbox());
  }

  void flap() async {
    velocity = jumpStrength;
    current = BirdMovement.up;
    await Future.delayed(const Duration(seconds: 0, milliseconds: 200));
    current = BirdMovement.middle;
    await Future.delayed(const Duration(seconds: 0, milliseconds: 200));
    current = BirdMovement.down;
  }

  @override
  void update(double dt) {
    velocity += gravity * dt;
    position.y += velocity * dt;
    if (position.y < 1) {
      (parent as FlappyBirdGame).gameOver();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }
    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
