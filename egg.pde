class Egg implements Entity{
  Egg(float x, float y, float age){
    _position = new PVector(x, y);
    _age = age;
  }
  
  void update(){
    _age++;
  }
  
  void draw(){
  
    pushMatrix();
    scale(0.1);
    resources.draw("egg.png");
    popMatrix();
  
  }
  boolean shouldDie(){return false;}
  void die(){}
  float life(){
    return _life;
  }
  float age(){
    return _age;
  }

  int width(){return 0;}
  int height(){return 0;}

  float x(){
    return _position.x;
  }
  float y(){
    return _position.y;
  }
  PVector position(){return _position;};
  
  EntityType type(){return EntityType.Egg;}
  void callCollidingEvent(EntityType type){}

  private PVector _position = new PVector();
  private float _life;
  private float _age;
}
