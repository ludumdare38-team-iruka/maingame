enum GameState{
  Opening,
  Tutorial,
  Gaming,
  GameOver,
  GameClear
}

class Game extends Scene{
  void setup(){
    _collisionDetector = new CollisionDetector();
    _player = new Player(200, 200);
    _entities.add(_player);
    _fishes.add(_player);

    Minion minion = new Minion(200, 200);
    _entities.add(minion);
    _fishes.add(minion);
    
    Enemy enemy = new Enemy(0,0);
    _entities.add(enemy);
    
    Egg egg = new Egg(0,0);
    _entities.add(egg);
  }

  void update(){
    for(Entity entity : _entities){
      entity.update();
    }

    updateEntities();
  }

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
  private List<Fish> _fishes     = new ArrayList<Fish>();
  private Player _player;

  private void updateEntities(){
    _collisionDetector.update(_entities);
  }
}

Resources resources = new Resources();
Scene currentScene;

void setup(){
  //720p
  size(1280, 720);
  resources.minim = new Minim(this);
  Game game = new Game();
  game.setup();
  currentScene = game;
}

void draw(){
  currentScene.update();
  currentScene.draw();
}