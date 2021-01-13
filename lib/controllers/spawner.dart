import 'package:break_the_egg/components/throw-egg.dart';
import 'package:break_the_egg/egg-game.dart';

class EggSpawner {
  final EggGame game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 7;
  int currentInterval;
  int nextSpawn;

  EggSpawner(this.game) {
    start();
    game.spawnEgg();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.eggs.forEach((ThrowEgg fly) => fly.isDead = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.eggs.forEach((ThrowEgg fly) {
      if (!fly.isDead) livingFlies += 1;
    });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnEgg();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
