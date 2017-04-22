enum GameState{
  Opening,
  Tutorial,
  Gaming,
  GameOver,
  GameClear
}

class Game{
  void setup(){}
  void update(){}
  void draw(){}
}

Game game = new Game();

void setup(){
  size(800, 800);
  game.setup();
}

void draw(){
  game.update();
  game.draw();
}
