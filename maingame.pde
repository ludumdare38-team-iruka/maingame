enum GameState{
  Opening,
  Tutorial,
  Gaming,
  GameOver,
  GameClear,
  Credit
}

int GAMESCORE = 0;

void drawGameScore(){
  String str;
  String[] score;
  int x = int(screenSize.x) -230;
 
  str = nf(GAMESCORE, 8);
  score = str.split("");
 
  for(int i=0; i<str.length(); i++){
    pushMatrix();
    translate(x, 40);
    scale(0.3);
    resources.draw(score[i] + ".png");
    popMatrix();
   
    x += 30;
  }
}

import java.util.ListIterator;
class Game extends Scene{
  Game(){
    GAMESCORE = 0;
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
    if(isPause){
      return;
    }
    spawnEnemies();
    
    if(int(_counter)%1800 == 0){
      spawnCrown();
    }

    _attack = _player.attack()/_fishes.size();
    for(Enemy enemy: _enemies){
      float dist = _player.position().dist(enemy.position());
      if(dist < _player.width()){
        if(_counter%15 == 0 && enemy.life()>0)resources.trigger("SE-7.mp3");
        enemy.life(enemy.life()-_attack);
      }
    }

    if(_mousePressing && _player.charisma > 0){
      if(seCount == 0){
        resources.play("SE-6.mp3");
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
    if(seCount > 0 || (_mousePressing && _player.charisma > 0)){
      seCount++;
    }
    if(seCount > 40){
      seCount = 0;
      resources.close("SE-6.mp3");
    }
    _boidsManager.update(_player.position(), _fishes);

    for(Entity entity : _entities){
      entity.update();
    }

    spawnFishes();
    updateEntitieEvents();
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

    if(_mousePressing && _player.charisma > 0){
      pushStyle();
      stroke(255, 220, 0);
      noFill();
      int n = int(ceil( _player.charisma/5000.0*5.0) );
      for(int i = 0; i<n;i++){
        float r = ((_counter*0.5+i*2)%15) / 15 * 200.0;
        ellipse(_player.position().x, _player.position().y, r, r);
      }
      popStyle();
    }

    if(isPause){
      pushMatrix();
      translate(screenSize.x/2, screenSize.y/2);
      resources.draw("pause.png");
      popMatrix();
    }
    
    drawGameScore();
  }

  void keyReleased(){
    if(key == ' '){
      isPause = !isPause;
      if(isPause){
        resources.trigger("SE-8.mp3");
        resources.pause("play.mp3");
        //ポーズ時の音が完成したら書換える
        //resources.play("");
      }else{
        //ポーズ解除時の音が完成したら書換える
        //resources.play("");
        resources.loop("play.mp3");
        resources.trigger("SE-9.mp3");
      }
    }
  }
  void mousePressed(){
    _mousePressing = true;
  }

  void mouseReleased(){
    _mousePressing = false;
  }
  Scene nextScene(){
    if(_isGameClear)return(new Gameclear(_initialEggs - _eatenEggs));
    return(new Gameover(_initialEggs - _eatenEggs));
  }

  private CollisionDetector _collisionDetector;
  private BoidsManager _boidsManager;

  //GameObjectLists
  private List<Entity> _entities = new ArrayList<Entity>();
  private List<Fish> _fishes     = new ArrayList<Fish>();
  private List<Enemy> _enemies = new ArrayList<Enemy>();

  private Player _player;
  private float _attack= 0;

  private float _counter = 0;

  //System frags
  private boolean _isGameClear = false;
  private boolean _mousePressing = false;
  private int seCount = 0;
  private boolean isPause = false;

  //Eggs
  private int _initialEggs = 0;
  private int _eggs        = 0;
  private int _eatenEggs   = 0;

  private void spawnEnemies(){
    if(20*30 < _counter && _counter < 1*60*30){
      if(int(_counter+1)%1000== 0){
        spawnJellyFish();
      }
    }

    if( 1*60*30 < _counter && _counter < 2*60*30){
      if(int(_counter+1)%800 == 0){
        spawnOctopus();
      }

      if(int(_counter+1)%1000== 0){
        spawnJellyFish();
      }
    }

    if( 2*60*30 < _counter && _counter < 3*60*30){
      if(int(_counter+1)%800 == 0){
        spawnOctopus();
      }

      if(int(_counter+1)%800 == 0){
        spawnSeahorse();
      }

      if(int(_counter+1)%1000== 0){
        spawnJellyFish();
      }
    }

    if( 3*60*30 < _counter && _counter < 5*60*30){
      if(int(_counter+1)%800 == 0){
        spawnOctopus();
      }

      if(int(_counter+1)%800 == 0){
        spawnSeahorse();
      }

      if(int(_counter+1)%550 == 0){
        spawnMaguro();
      }

      if(int(_counter+1)%1000== 0){
        spawnJellyFish();
      }
    }
  }

  private void spawnMaguro(){
    Maguro maguro = new Maguro(random(0, screenSize.x), 0, 640+random(-50, 50), 650);
    _entities.add(maguro);
    _enemies.add(maguro);
  }

  private void spawnJellyFish(){
    JellyFish jellyFish = new JellyFish(random(0, screenSize.x), 0, 640+random(-50, 50), 650);
    _entities.add(jellyFish);
    _enemies.add(jellyFish);
  }

  private void spawnOctopus(){
    Octopus enemy= new Octopus(random(0, screenSize.x), 0, 640+random(-50, 50), 650);
    _entities.add(enemy);
    _enemies.add(enemy);
  }

  private void spawnSeahorse(){
    Seahorse enemy= new Seahorse(random(0, screenSize.x), 0, 640+random(-50, 50), 650);
    _entities.add(enemy);
    _enemies.add(enemy);
  }


  private void spawnCrown(){
    Crown crown = new Crown();
    _entities.add(crown);
  }

  private void updateEntitieEvents(){
    _collisionDetector.update(_entities);

    ListIterator<Entity> itr = _entities.listIterator();
    while(itr.hasNext()){
      Entity entity = itr.next();
      if(entity.shouldDie()){ 
        if(entity.type() == EntityType.Egg){
          _eatenEggs++;
        }

        if(entity.type() == EntityType.Enemy){ 
          GAMESCORE += entity.maxLife() * (_initialEggs-_eggs-_eatenEggs)*_attack;
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

  private void drawUserInterface(){
    pushMatrix();
    translate(0, screenSize.y-100);
    drawGage();
    popMatrix();
    
    pushMatrix();
    translate(1095, screenSize.y-80);
    scale(0.32);
    resources.draw("minion.png");
    popMatrix();
    drawScore();
    
    pushMatrix();
    translate(1100,screenSize.y-40);
    scale(0.22);
    resources.draw("egg.png");
    popMatrix();
    drawEggLife();
    
  }
  
  private void drawGage(){
    float rate = 1.0;
    rate = min(max(_attack, 0), 1);
    fill(255, 32, 64);
    rect(60, 26, rate*315f, 40);
    resources.draw("gage.png", 0, 0);
  }
  
  private void drawScore(){
    String str;
    String[] life;
    int x = 1150;
    
    str = nf(_initialEggs - _eggs - _eatenEggs, 3);
    life = str.split("");
    
    for(int i=0; i<str.length(); i++){
      pushMatrix();
      translate(x, screenSize.y-80);
      scale(0.32);
      resources.draw(life[i] + ".png");
      popMatrix();
      
      x += 35;
    }
  }   
  
  private void drawEggLife(){
    String str;
    String[] life;
    int x = 1150;
    
    str = nf(_eggs, 3);
    life = str.split("");
    
    for(int i=0; i<str.length(); i++){
      pushMatrix();
      translate(x, screenSize.y-40);
      scale(0.22);
      resources.draw(life[i] + ".png");
      popMatrix();
      
      x += 35;
    }
  }
}

Resources resources = new Resources();
Scene currentScene;

PVector screenSize;
boolean isPause = false;

void setup(){
  frameRate(30);
  strokeWeight(2);
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