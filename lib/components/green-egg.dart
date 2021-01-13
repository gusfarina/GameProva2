import 'dart:ui';
import 'package:break_the_egg/components/throw-egg.dart';
import 'package:flame/sprite.dart';
import '../egg-game.dart';

class GreenEgg extends ThrowEgg {
  double get speed => game.tileSize * 10;

  GreenEgg(EggGame game, double x, double y) : super(game) {
    resize(x: x, y: y);
    flyingSprite = Sprite('green_egg.png');
    deadSprite = Sprite('green_splash.png');
    isBomb = true;
  }

  void resize({double x, double y}) {
    x ??= (flyRect?.left) ?? 0;
    y ??= (flyRect?.top) ?? 0;
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1 , game.tileSize * 1);
    super.resize();
  }
}
