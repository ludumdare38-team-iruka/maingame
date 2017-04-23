class Enemy implements Entity{  
  Enemy(float x, float y){
  }
  
  void update(){
    
  }
  
  void draw(){
    
    pushMatrix();
    scale(0.4);
    resources.draw("maguro.png");
    popMatrix();
  
  }
  boolean shouldDie(){return false;}
  void die(){}

  int width(){return 0;}
  int height(){return 0;}

  float x(){return 650;}
  float y(){return 300;}
  
  EntityType type(){return EntityType.Enemy;}
  void callCollidingEvent(EntityType type){}

}
  