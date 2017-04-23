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
    if(charisma>0){
      charisma-=1.0;
      charisma = max(charisma, 0);
    }
  }
  
  void draw(){
    float angle;
    pushMatrix();
    if(_direction.mag() < maxSpeed){
      angle = 0;
    }else{
      if(_direction.x>0){
        PVector tmp =  new PVector(_direction.x, _direction.y);
        angle = tmp.heading();
      }else{
        PVector tmp =  new PVector(-_direction.x, -_direction.y);
        angle = tmp.heading();
      }
    }
    angle = max(min(angle, PI*0.3), -PI*0.3);
    rotate(angle);
    if(_direction.x>0){
      scale(0.2, 0.2);
    }else{
      scale(-0.2, 0.2);
    }
    resources.draw("player.png");
    if(charisma > 0){
      drawCrown();
    }
    popMatrix();
  }

  private void drawCrown(){
    pushMatrix();
    translate(40, -85);
    scale(0.5);
    resources.draw("crown.png");
    popMatrix();
  }

  boolean shouldDie(){return false;}
  void die(){}
  float life(){return 0;}
  float age(){return 0;}

  int width(){return 10;}
  int height(){return 10;}

  float x(){return _position.x;}
  float y(){return _position.y;}
  PVector position(){return _position;};
  void position(PVector p){_position = p;};
  PVector target(){return _target;}
  void target(PVector p){_target = p;}
  PVector velocity(){return _velocity;};

  PVector direction(){return _direction;}

  void attraction(float p){};
  
  EntityType type(){return EntityType.Player;}

  void callCollidingEvent(EntityType type){
    if(type == EntityType.Crown){
      charisma+=5000;
    }
  }

  void fishes(List<Fish> arr){
  }


  void calcVelocity(){}

  private PVector _position;
  private PVector _target;
  private PVector _direction;
  private PVector _velocity;
  private int maxSpeed = 5;
  private float charisma = 0;
}
