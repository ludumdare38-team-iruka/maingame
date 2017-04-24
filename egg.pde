class Egg implements Entity{
  Egg(float x, float y, float age){
    _position = new PVector(x, y);
    _age = age;
  }
  
  void update(){
    _age++;
    if(_life<0)_shouldDie = true;
  }
  
  void draw(){
    pushMatrix();
    scale(0.1);
    resources.draw("egg.png");
    popMatrix();
    
  }

  boolean shouldDie(){return _shouldDie;}

  void die(){}
  float life(){
    return _life;
  }
  float age(){
    return _age;
  }

  int width(){return 10;}
  int height(){return 10;}

  float x(){
    return _position.x;
  }
  float y(){
    return _position.y;
  }
  PVector position(){return _position;};
  
  EntityType type(){return EntityType.Egg;}
  void callCollidingEvent(EntityType type){
    if(type == EntityType.Enemy){_life--;}
  }

  private PVector _position = new PVector();
  private float _life = 100;
  private float _age;
  private boolean _shouldDie = false;
}
