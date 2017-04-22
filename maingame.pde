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
  //720p
  size(1280, 720);
  game.setup();
}

void draw(){
  game.update();
  game.draw();
}
