import 'dart:ui';
import 'package:break_the_egg/components/throw-egg.dart';
import 'package:flame/sprite.dart';
import '../egg-game.dart';

class Egg extends ThrowEgg {
  double get speed => game.tileSize * 10;

  Egg(EggGame game, double x, double y) : super(game) {
    resize(x: x, y: y);
    flyingSprite = Sprite('egg.png');
    deadSprite = Sprite('splash.png');
  }

  void resize({double x, double y}) {
    x ??= (flyRect?.left) ?? 0;
    y ??= (flyRect?.top) ?? 0;
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1 , game.tileSize * 1);
    super.resize();
  }
}
