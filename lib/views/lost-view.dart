import 'dart:ui';
import 'package:break_the_egg/egg-game.dart';
import 'package:flame/sprite.dart';

class LostView {
  final EggGame game;
  Rect rect;
  Sprite sprite;

  LostView(this.game) {
    resize();
    sprite = Sprite('lost.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );
  }
}
