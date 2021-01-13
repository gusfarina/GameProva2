import 'dart:ui';
import 'package:break_the_egg/state.dart';
import 'package:flame/sprite.dart';
import '../egg-game.dart';


class StartButton {
  final EggGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    resize();
    sprite = Sprite('play.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
  }

  void onTapDown() {
    game.score = 0;
    game.activeView = State.INGAME;
    game.spawner.start();
  }
}
