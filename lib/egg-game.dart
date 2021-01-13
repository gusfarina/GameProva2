import 'dart:math';
import 'dart:ui';
import 'package:break_the_egg/components/background.dart';
import 'package:break_the_egg/components/throw-egg.dart';
import 'package:break_the_egg/state.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/Egg.dart';
import 'components/green-egg.dart';
import 'components/highscore-display.dart';
import 'components/score-display.dart';
import 'components/start-button.dart';
import 'controllers/spawner.dart';
import 'controllers/spawner.dart';
import 'views/home-view.dart';
import 'views/lost-view.dart';

class EggGame extends Game {
  final SharedPreferences storage;
  Size screenSize;
  double tileSize;
  Random rnd;

  Background background;
  List<ThrowEgg> eggs;
  StartButton startButton;
  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;

  EggSpawner spawner;

  State activeView = State.HOME;
  HomeView homeView;
  LostView lostView;

  int score;

  EggGame(this.storage) {
    initialize();
  }

  Future<void> initialize() async {
    rnd = Random();
    eggs = List<ThrowEgg>();
    score = 0;
    resize(Size.zero);

    background = Background(this);
    startButton = StartButton(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);

    spawner = EggSpawner(this);
    homeView = HomeView(this);
    lostView = LostView(this);
  }

  void spawnEgg() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
    // double y = (rnd.nextDouble() * (screenSize.height - (tileSize * 2.025))) + (tileSize * 1.5);
    double y = screenSize.height - (tileSize * 2.025);
    switch (rnd.nextInt(2)) {
      case 0:
        eggs.add(Egg(this, x, y));
        break;
      case 1:
        eggs.add(GreenEgg(this, x, y));
        break;
    }

  }

  void render(Canvas canvas) {
    background.render(canvas);

    highscoreDisplay.render(canvas);
    if (activeView == State.INGAME || activeView == State.GAMEOVER) scoreDisplay.render(canvas);

    eggs.forEach((ThrowEgg egg) => egg.render(canvas));

    if (activeView == State.HOME) homeView.render(canvas);
    if (activeView == State.GAMEOVER) lostView.render(canvas);
    if (activeView == State.HOME || activeView == State.GAMEOVER) {
      startButton.render(canvas);
    }
  }

  void update(double t) {
    spawner.update(t);
    eggs.forEach((ThrowEgg egg) => egg.update(t));
    eggs.removeWhere((ThrowEgg egg) => egg.isOffScreen);
    if (activeView == State.INGAME) scoreDisplay.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;

    background?.resize();

    highscoreDisplay?.resize();
    scoreDisplay?.resize();
    eggs.forEach((ThrowEgg egg) => egg?.resize());

    homeView?.resize();
    lostView?.resize();

    startButton?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // start button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == State.HOME || activeView == State.GAMEOVER) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    // flies
    if (!isHandled) {
      bool didHitAFly = false;
      eggs.forEach((ThrowEgg egg) {
        if (egg.flyRect.contains(d.globalPosition)) {
          egg.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });

    }
  }
}
