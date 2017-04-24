class Maguro implements Entity, Enemy{  
  Maguro(float x, float y,float tx, float ty){
    _position = new PVector(x,y);
    _target = new PVector(tx,ty);
  }
  

  
  void update(){
    if(_status == MaguroStatus.Move){
      moving();
    }else if(_status == MaguroStatus.Escape){
      escape();
    }else{
      _status = MaguroStatus.Move;
    }

    if(_life < 0 && _status != MaguroStatus.Escape){
      _status = MaguroStatus.Escape;
      speed = 4.0;
      _target = new PVector(random(0, screenSize.x), 0);
    }
  }

  void escape(){
    moving();
    float x = _position.x;
    float y = _position.y;
    if( x < 0 || x > screenSize.x || y < 0){
      _shouldDie = true;
    }
  }

  void moving(){
    float angle; 
    float ex,ey;
    
    angle = atan2(_target.y - _position.y, _target.x - _position.x);
   
    ex = speed*cos(angle);
    ey = speed*sin(angle);
    
    _position.x += ex;
    _position.y += ey;
    
    _direction = new PVector(ex, ey);
  }
  
  void draw(){
    float angle;
    
    //angle = atan2(_direction.y, _direction.x);
    if(_status == MaguroStatus.Stop){
      angle = 0;
    }else{
      if(_direction.x>0){
        PVector tmp =  new PVector(_direction.x, _direction.y);
        angle = tmp.heading();
      }else{
        PVector tmp =  new PVector(-_direction.x, -_direction.y);
        angle = tmp.heading();
      }
      angle = max(min(angle, PI*0.3), -PI*0.3);
    }
    
    pushMatrix();
    
    rotate(angle);
    if(_direction.x > 0){
      scale(-0.3,0.3);
    }else{
      scale(0.3);
    }
    resources.draw("maguro.png");
    popMatrix();
  

  }
  boolean shouldDie(){return _shouldDie;}
  void die(){}
  float life(){return 0;};
  float age(){return 0;};

  int width(){return 50;}
  int height(){return 50;}

  float x(){return _position.x;}
  float y(){return _position.y;}
  PVector position(){return _position;};
  PVector direction(){return _direction;};
  void fishDensity(float d){_fishDensity = d;}

  
  EntityType type(){return EntityType.Enemy;}
  void callCollidingEvent(EntityType type){
    if(type == EntityType.Egg){
      _status = MaguroStatus.Stop;
    };

    if(type == EntityType.Player){
      _life -= _fishDensity;
      _fishDensity = 0;
    }
  }

  private PVector _position = new PVector();
  private PVector _direction = new PVector();
  private PVector _target = new PVector();
  private float _life = 200;
  private float _fishDensity = 0;
  private boolean _shouldDie = false;
  private float speed = 1.5;
  private MaguroStatus _status = MaguroStatus.Move;
}

enum MaguroStatus{
  Move,
  Escape,
  Stop
}
