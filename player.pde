class Player implements Entity, Fish{

  Player(float x, float y){
    _position = new PVector(x, y);
    _direction = new PVector(0, 0);
  }
  
  void update(){}
  
  void draw(){
    
    float angle;
    
    angle = atan2(_direction.x,_direction.y);
    
    pushMatrix();
    translate(_position.x,_position.y);
    rotate(angle);
    scale(0.5);
    resources.draw("player.png");
    popMatrix();
  }

  boolean shouldDie(){return false;}
  void die(){}

  int width(){return 0;}
  int height(){return 0;}

  float x(){return _position.x;}
  float y(){return _position.y;}

  PVector direction(){return _direction;}
  
  EntityType type(){return EntityType.Player;}

  void callCollidingEvent(EntityType type){}

  private PVector _position;
  private PVector _direction;
}
