class Egg implements Entity{
  Egg(float x, float y){
  }
  
  void update(){}
  
  void draw(){
  
    pushMatrix();
    scale(0.3);
    resources.draw("egg.png");
    popMatrix();
  
  }
  boolean shouldDie(){return false;}
  void die(){}

  int width(){return 0;}
  int height(){return 0;}

  float x(){return 640;}
  float y(){return 640;}
  PVector position(){return _position;};
  
  EntityType type(){return EntityType.Egg;}
  void callCollidingEvent(EntityType type){}

  private PVector _position = new PVector();
}
