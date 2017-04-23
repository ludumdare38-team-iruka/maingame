class Player implements Entity, Fish{

  Player(float x, float y){
    _position = new PVector(x, y);
    _direction = new PVector(0, 0);
    _velocity = new PVector(0, 0);
  }
  
  void update(){
    if(charisma>0){
      charisma-=1.0;
      charisma = max(charisma, 0);
    }
  }
  
  void draw(){
    
    float angle;
    
    angle = atan2(_direction.x,_direction.y);
    
    pushMatrix();
    rotate(angle);
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
  PVector velocity(){return _velocity;};

  PVector direction(){return _direction;}

  void attraction(float p){};
  
  EntityType type(){return EntityType.Player;}

  void callCollidingEvent(EntityType type){}

  void fishes(List<Fish> arr){
  }

  void target(PVector p){}

  void calcVelocity(){}

  private PVector _position;
  private PVector _direction;
  private PVector _velocity;
  private float charisma = 0;
}
