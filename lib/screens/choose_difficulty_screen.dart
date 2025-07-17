import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/variables.dart';
import 'package:flutter/material.dart';
import 'package:flappy_bird/assets.dart';

class ChooseDifficultyscreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'chooseDifficulty';

  const ChooseDifficultyscreen({Key? key, required this.game})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.menu),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select difficulty:',
                style: const TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontFamily: 'Pixel',
                ),
              ),
              ElevatedButton(
                onPressed: onStartEasy,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Easy',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Pixel',
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: onStartHard,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Hard',
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
      ),
    );
  }

  void onStartEasy() {
    game.overlays.remove('chooseDifficulty');
    pipeGap = 300;
    groundScrollingSpeed = 200;
    game.resetGame();
    game.resumeEngine();
  }

  void onStartHard() {
    game.overlays.remove('chooseDifficulty');
    groundScrollingSpeed = 300;
    pipeGap = 250;
    game.resetGame();
    game.resumeEngine();
  }
}
