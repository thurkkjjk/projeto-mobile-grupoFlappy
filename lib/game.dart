import 'dart:async';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flappy_bird/components/pipe_manager.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/components/score.dart';
import 'package:flappy_bird/variables.dart';
import 'components/bird.dart';
import 'components/background.dart';
import 'components/ground.dart';
import 'package:flame_audio/flame_audio.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;
  late AudioPool wing;
  late AudioPool point;
  late AudioPool hit;

  @override
  FutureOr<void> onLoad() async {
    await FlameAudio.audioCache.loadAll([
      'wing.wav',
      'point.wav',
      'hit.wav',
    ]); // Pré-carrega os sons
    wing = await FlameAudio.createPool(
      // A documentação recomendou criar AudioPools para que os sons toquem corretamente
      'wing.wav',
      minPlayers: 3,
      maxPlayers: 6,
    );
    point = await FlameAudio.createPool(
      'point.wav',
      minPlayers: 2,
      maxPlayers: 4,
    );
    hit = await FlameAudio.createPool('hit.wav', minPlayers: 1, maxPlayers: 2);

    background = Background(size);
    add(background);

    bird = Bird();
    add(bird);

    ground = Ground();
    add(ground);

    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);
  }

  @override
  void onTap() {
    bird.flap();
    playFlapSound();
  }

  void playFlapSound() async {
    await wing.start();
  }

  void playPointSound() async {
    await point.start();
  }

  void playHitSound() async {
    await hit.start();
  }

  int score = 0;
  int highScore = 0;

  void incrementScore() {
    score += 1;
    playPointSound();
  }

  bool isGameOver = false;

  void gameOver() {
    if (highScore < score) highScore = score;
    if (isGameOver) return;
    playHitSound();
    isGameOver = true;
    pauseEngine();
    overlays.add('gameOver');
  }

  void resetGame() async {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
