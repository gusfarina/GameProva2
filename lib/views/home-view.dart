import 'dart:ui';
import 'package:break_the_egg/egg-game.dart';
import 'package:flame/sprite.dart';

class HomeView {
  final EggGame game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    resize();
    titleSprite = Sprite('logo.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 4),
      game.tileSize * 7,
      game.tileSize * 3.5,
    );
  }
}
