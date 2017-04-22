class Player implements Entity, Fish{
  Player(float x, float y){
    _position = new PVector(x, y);
  }
  
  void update(){}
  
  void draw(){
    ellipse(0,0,40,20);
  }

  boolean shouldDie(){return false;}
  void die(){}

  int width(){return 0;}
  int height(){return 0;}

  float x(){return 0;}
  float y(){return 0;}

  PVector direction(){return _direction;}
  
  EntityType type(){return EntityType.Player;}

  void callCollidingEvent(EntityType type){

  }

  private PVector _position;
  private PVector _direction;
}
