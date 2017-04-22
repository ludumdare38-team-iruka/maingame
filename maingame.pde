enum GameState{
  Opening,
  Tutorial,
  Gaming,
  GameOver,
  GameClear
}

class Game{
  void setup(){
    _collisionDetector = new CollisionDetector();
  }

  void update(){}

  void draw(){}

  private CollisionDetector _collisionDetector;
  private List<Entity> _entities = new ArrayList<Entity>();
}

Resources resources = new Resources();
Game game = new Game();

void setup(){
  //720p
  size(1280, 720);
  resources.minim = new Minim(this);
  game.setup();
}

void draw(){
  game.update();
  game.draw();
}
