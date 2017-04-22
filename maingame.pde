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
    _player = new Player(200, 200);
    _entities.add(_player);
  }

  void update(){}

  void draw(){
    for(Entity entity : _entities){
      pushMatrix();
      translate(entity.x(), entity.y());
      entity.draw();
      popMatrix();
    }
  }

  private CollisionDetector _collisionDetector;
  private List<Entity> _entities = new ArrayList<Entity>();
  private Player _player;
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
