class Minion implements Entity, Fish{
  Minion(float x, float y){
    _position = new PVector(x, y);
  }
  
  void update(){}
  
  void draw(){
    pushMatrix();
    scale(0.5);
    resources.draw("minion.png");
    popMatrix();
  }
  boolean shouldDie(){return false;}
  void die(){}

  int width(){return 0;}
  int height(){return 0;}

  float x(){return _position.x;}
  float y(){return _position.y;}

  PVector direction(){return _direction;}
  
  EntityType type(){return EntityType.Minion;}

  void callCollidingEvent(EntityType type){}

  private PVector _position;
  private PVector _direction;
}
