enum GameState{
  Opening,
  Tutorial,
  Gaming,
  GameOver,
  GameClear
}

class Game extends Scene{
  Game(){
    _collisionDetector = new CollisionDetector();
    _player = new Player(200, 200);
    _entities.add(_player);
    _fishes.add(_player);

    Minion minion = new Minion(200, 200);
    _entities.add(minion);
    _fishes.add(minion);
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
  void mousePressed(){
    _isFinish = true;
    if(mouseButton == LEFT){
      isGameClear = true;
    }
  }
  Scene nextScene(){
    if(isGameClear)return(new Gameclear());
    return(new Gameover());
  }
  private CollisionDetector _collisionDetector;
  private List<Entity> _entities = new ArrayList<Entity>();
  private List<Fish> _fishes     = new ArrayList<Fish>();
  private Player _player;
  private boolean isGameClear = false;
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
  currentScene = new Opening();
}

void draw(){
  currentScene.update();
  currentScene.draw();
  if(currentScene.isFinish()){
    currentScene = currentScene.nextScene();
    if(currentScene instanceof NullScene){
      exit();
      return;
    }
  }
}
void keyPressed(){
  currentScene.keyPressed();
}
void keyReleased(){
  currentScene.keyReleased();
}
void mousePressed(){
  currentScene.mousePressed();
}
void mouseReleased(){
  currentScene.mouseReleased();
}
