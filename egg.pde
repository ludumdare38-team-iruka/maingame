class Egg implements Entity{
  
  void update(){}
  
  void draw(){}
  boolean shouldDie(){return false;}
  void die(){}

  int width(){return 0;}
  int height(){return 0;}

  float x(){return 0;}
  float y(){return 0;}
  
  EntityType type(){return EntityType.Egg;}
  void callCollidingEvent(EntityType type){}
}
