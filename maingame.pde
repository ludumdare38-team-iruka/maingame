enum GameState{
  Opening,
  Tutorial,
  Gaming,
  GameOver,
  GameClear
}

import java.util.ListIterator;
class Game extends Scene{
  Game(){
    _collisionDetector = new CollisionDetector();
    _boidsManager = new BoidsManager();

    _player = new Player(500, 200);
    _entities.add(_player);
    _fishes.add(_player);

    Minion minion = new Minion(200, 200);
    _entities.add(minion);
    _fishes.add(minion);
    
    Enemy enemy = new Enemy(0,0);
    _entities.add(enemy);

    // Crown crown = new Crown();
    // _entities.add(crown);
    
    for(int i = 0; i < 50; i++){
      Egg egg = new Egg(640+random(-50, 50),640 + random(0, 50), 5*60*30-i*5*60*30/50);
      _entities.add(egg);
    }
  }

  void update(){
    println(_counter);
    if(int(_counter)%2000 == 0){
      spawnCrown();
    }

    if(_mousePressing && _player.charisma > 0){
      _player.charisma-=1.0f;
      float attraction = 4.0;
      for(Fish fish: _fishes){
        fish.attraction(attraction);
      }
    }else{
      for(Fish fish: _fishes){
        fish.attraction(0.0);
      }
    }

    _player.position(new PVector(mouseX, mouseY));
    _boidsManager.update(_player.position(), _fishes);


    for(Entity entity : _entities){
      entity.update();
    }

    spawnEggs();
    updateEntities();
    checkFinished();

    _counter++;
  }



  void draw(){
    resources.draw("background.png", 0, 0);
    for(Entity entity : _entities){
      pushMatrix();
      translate(entity.x(), entity.y());
      entity.draw();
      popMatrix();
    }
  }

  void mousePressed(){
    _mousePressing = true;
  }

  void mouseReleased(){
    _mousePressing = false;
  }

  Scene nextScene(){
    if(isGameClear)return(new Gameclear());
    return(new Gameover());
  }

  private CollisionDetector _collisionDetector;
  private BoidsManager _boidsManager;
  private List<Entity> _entities = new ArrayList<Entity>();
  private List<Fish> _fishes     = new ArrayList<Fish>();
  private Player _player;
  private boolean isGameClear = false;
  private boolean _mousePressing = false;
  private float _counter = 0;

  private void spawnCrown(){
    Crown crown = new Crown();
    _entities.add(crown);
  }

  private void updateEntities(){
    _collisionDetector.update(_entities);

    ListIterator<Entity> itr = _entities.listIterator();
    while(itr.hasNext()){
      Entity entity = itr.next();
      if(entity.shouldDie())itr.remove();
    }
  }

  private void spawnEggs(){
    ListIterator<Entity> itr = _entities.listIterator();
    while(itr.hasNext()){
      Entity entity = itr.next();
      if(entity.type() == EntityType.Egg && entity.age() > 5*60*30){
        Minion m = new Minion(entity.position().x, entity.position().y);
        itr.set(m);
        _fishes.add(m);
        // itr.remove();
      }
    }
  }

  private void checkFinished(){
    int eatenEggs = 0; //TODO
    int eggs = 0;
    for(Entity entity : _entities){
      if(entity.type() == EntityType.Egg)eggs++;
    }

    if(eggs == 0){
      _isFinish = true;
      isGameClear = true;//TODO
    }
  }

  private float fishDensity(){
    PVector avgPosition = fishAvgPosition();
    int count = 0;
    float sum = 0;
    for(Fish fish: _fishes){
      PVector diff = PVector.sub(avgPosition, fish.position());
      sum = PVector.dot(diff, diff);
      count++;
    }
    return sum/float(_fishes.size());
  }

  private PVector fishAvgPosition(){
    PVector sum = new PVector();
    for(Fish fish: _fishes){
      sum.add(fish.position());
    }
    return sum.div(float(_fishes.size()));
  }
}

Resources resources = new Resources();
Scene currentScene;

PVector screenSize;

void setup(){
  screenSize = new PVector(1280, 720);
  //720p
  size(1280, 720);
  resources.minim = new Minim(this);
  currentScene = new Opening();
}

void draw(){
  background(128);
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
