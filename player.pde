class Player implements Entity, Fish{

  Player(float x, float y){
    _position = new PVector(x, y);
    _target = new PVector(x, y);
    _direction = new PVector(0, 0);
    _velocity = new PVector(0, 0);
  }
  
  void update(){
    _target = new PVector(mouseX, mouseY);
    PVector diff = PVector.sub(_target, _position);
    float move = min(diff.mag(), maxSpeed);
    diff.normalize().mult(move);
    _position.add(diff);
    _direction = diff;
  }
  
  void draw(){
    float angle;
    if(_direction.mag() < maxSpeed / 2){
      angle = 0;
    }else{
      angle = _direction.heading();
    }
    pushMatrix();
    rotate(angle);
    if(abs(degrees(angle)) >=90){
      scale(1, -1);
    }
    scale(0.2);
    resources.draw("player.png");
    popMatrix();
  }

  boolean shouldDie(){return false;}
  void die(){}
  float life(){return 0;}
  float age(){return 0;}

  int width(){return 0;}
  int height(){return 0;}

  float x(){return _position.x;}
  float y(){return _position.y;}
  PVector position(){return _position;};
  void position(PVector p){_position = p;};
  PVector target(){return _target;}
  void target(PVector p){_target = p;}
  PVector velocity(){return _velocity;};

  PVector direction(){return _direction;}
  
  EntityType type(){return EntityType.Player;}

  void callCollidingEvent(EntityType type){}

  void fishes(List<Fish> arr){
  }


  void calcVelocity(){}

  private PVector _position;
  private PVector _target;
  private PVector _direction;
  private PVector _velocity;
  private int maxSpeed = 5;
}
