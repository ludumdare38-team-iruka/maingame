class Minion implements Entity{
  
  void update(){}
  
  void draw(){}
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
