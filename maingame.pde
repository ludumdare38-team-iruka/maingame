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
    resources.loop("play.mp3");
    _collisionDetector = new CollisionDetector();
    _boidsManager = new BoidsManager();

    _player = new Player(500, 200);
    _entities.add(_player);
    _fishes.add(_player);

    Minion minion = new Minion(200, 200);
    _entities.add(minion);
    _fishes.add(minion);
    
    _initialEggs = 50;
    spawnEggs();
  }

  void update(){
    if(int(_counter+1)%1000 == 0){
      spawnMaguro();
    }
    
    if(int(_counter)%2000 == 0){
      spawnCrown();
    }

    if(_mousePressing && _player.charisma > 0){
      if(charismaFlag == true){
        resources.trigger("SE-6.mp3");
        charismaFlag = false;
      }
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

    _boidsManager.update(_player.position(), _fishes);

    float fishDensity = fishDensity();
    updateEnemies(fishDensity*2.0f);

    for(Entity entity : _entities){
      entity.update();
    }

    spawnFishes();
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
    drawUserInterface();
  }

  void mousePressed(){
    charismaFlag = true;
    _mousePressing = true;
  }

  void mouseReleased(){
    _mousePressing = false;
  }

  Scene nextScene(){
    if(_isGameClear)return(new Gameclear());
    return(new Gameover());
  }

  private CollisionDetector _collisionDetector;
  private BoidsManager _boidsManager;

  //GameObjectLists
  private List<Entity> _entities = new ArrayList<Entity>();
  private List<Fish> _fishes     = new ArrayList<Fish>();
  private List<Enemy> _enemies = new ArrayList<Enemy>();

  private Player _player;

  private float _counter = 0;

  //System frags
  private boolean _isGameClear = false;
  private boolean _mousePressing = false;
  private boolean charismaFlag = false;

  //Eggs
  private int _initialEggs = 0;
  private int _eggs        = 0;
  private int _eatenEggs   = 0;

  private void spawnMaguro(){
    Maguro maguro = new Maguro(random(0, screenSize.x), 0, 640+random(-50, 50), 650);
    _entities.add(maguro);
    _enemies.add(maguro);
  }

  private void spawnCrown(){
    Crown crown = new Crown();
    _entities.add(crown);
  }

  private void updateEnemies(float fishDensity){
    for(Enemy enemy: _enemies){
      enemy.fishDensity(fishDensity);
    }
  }

  private void updateEntities(){
    _collisionDetector.update(_entities);

    ListIterator<Entity> itr = _entities.listIterator();
    while(itr.hasNext()){
      Entity entity = itr.next();
      if(entity.shouldDie()){ 
        if(entity.type() == EntityType.Egg){
          _eatenEggs++;
        }
        itr.remove();
      }
    }
  }
  private void spawnEggs(){
    for(int i = 0; i < _initialEggs; i++){
      Egg egg = new Egg(640+random(-50, 50),640 + abs(random(-50, 50)), 5*60*30-i*5*60*30/_initialEggs);
      _entities.add(egg);
      
    }
  }

  private void spawnFishes(){
    ListIterator<Entity> itr = _entities.listIterator();
    while(itr.hasNext()){
      Entity entity = itr.next();
      if(entity.type() == EntityType.Egg && entity.age() > 5*60*30){
        Minion m = new Minion(entity.position().x, entity.position().y);
        itr.set(m);
        _fishes.add(m);
        resources.trigger("SE-3.mp3");
        // itr.remove();
      }
    }
  }

  private void checkFinished(){
    _eggs = 0;
    for(Entity entity : _entities){
      if(entity.type() == EntityType.Egg)_eggs++;
    }

    if(_eggs == 0){
      resources.close("play.mp3");
      _isFinish = true;
      _isGameClear = _eatenEggs < _initialEggs/2;
    }
  }

  private float fishDensity(){
    PVector avgPosition = fishAvgPosition();
    float sum = 0;
    int count = 0;
    for(Fish fish: _fishes){
      // if(_player.equals(fish))continue;
      PVector diff = PVector.sub(_player.position(), fish.position());
      // PVector diff = PVector.sub(fishAvgPosition(), fish.position());
      float norm = diff.mag();
      sum += norm*norm;
      count++;
    }
    float result = (sum/count);
    return 1.0f/sqrt(result)*50;
  }

  private PVector fishAvgPosition(){
    PVector sum = new PVector();
    for(Fish fish: _fishes){
      sum.add(fish.position());
    }
    return sum.div(float(_fishes.size()));
  }

  private void drawUserInterface(){
    pushMatrix();
    translate(0, screenSize.y-100);
    drawGage();
    popMatrix();
    
    translate(1100,screenSize.y-60);
    pushMatrix();
    scale(0.3);
    resources.draw("egg.png");
    drawEggLife();
    popMatrix();
  }
  
  private void drawGage(){
    float rate = 1.0;
    rate = min(max(fishDensity(), 0), 1);
    fill(255, 32, 64);
    rect(60, 26, rate*315f, 40);
    resources.draw("gage.png", 0, 0);
    println(fishDensity());
  }
  
  private void drawEggLife(){
    String str;
    String[] life;
    
    str = nf(_eggs, 3);
    life = str.split("");
    
    for(int i=0; i<str.length(); i++){
      if(i == 0){
        translate(150, 0);
      }else if(i == 1){
        translate(100, 0);
      }else if(i == 2){
        translate(100, 0);
      }
      resources.draw(life[i] + ".png");
    }
  }
}

Resources resources = new Resources();
Scene currentScene;

PVector screenSize;

void setup(){
  frameRate(30);
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
