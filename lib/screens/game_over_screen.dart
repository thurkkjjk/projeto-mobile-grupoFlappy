import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';
import 'package:flappy_bird/assets.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'gameOver';

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.black38,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Score: ${game.score}',
            style: const TextStyle(
              fontSize: 45,
              color: Colors.white,
              fontFamily: 'Pixel',
            ),
          ),
          Text(
            'High score: ${game.highScore}',
            style: const TextStyle(
              fontSize: 45,
              color: Colors.white,
              fontFamily: 'Pixel',
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(Assets.gameOverText),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRestart,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text(
              'Restart',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Pixel',
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onDifficulty,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text(
              'Difficulty',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Pixel',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  void onRestart() {
    game.resetGame();
    game.overlays.remove('gameOver');
  }

  void onDifficulty() {
    game.overlays.remove('gameOver');
    game.overlays.add('chooseDifficulty');
  }
}
