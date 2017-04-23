class Crown implements Entity{
  Crown(){}

  void update(){
    _position.x = _age;
    _position.y = 50.0 + cos(_age*0.05)*40;
    if(_position.x > screenSize.x){
      _shouldDie = true;
    }
    _age++;
  }

  void draw(){
    pushMatrix();
    scale(0.2);
    resources.draw("crown.png");
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
  
  EntityType type(){return EntityType.Crown;}
  void callCollidingEvent(EntityType type){
    if(type == EntityType.Player){
      _shouldDie = true;
    }
  }

  private PVector _position = new PVector(0, 0);
  private float _life;
  private float _age;
  private boolean _shouldDie = false;
}
