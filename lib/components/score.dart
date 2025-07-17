import 'dart:async';
import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame> {
  ScoreText() : super(
    text: '0',
    textRenderer: TextPaint(
      style: TextStyle(
        color: Colors.white,
        fontSize: 70,
        fontFamily: 'Pixel'
      )
    )
    );

  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      (gameRef.size.x - size.x) / 2,
      gameRef.size.y - size.y - 50,
    );
  }

  @override
  void update(double dt) {
    final newText = gameRef.score.toString();
    if (text != newText) {
      text = newText;
    }
  }
}
