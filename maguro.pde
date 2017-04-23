class Maguro implements Entity, Enemy{  
  Maguro(float x, float y,float tx, float ty){
    _position = new PVector(x,y);
    _target = new PVector(tx,ty);
  }
  

  
  void update(){
    
    float speed = 1.5;
    float angle; 
    float ex,ey;
    
    angle = atan2(_target.y - _position.y, _target.x - _position.x);
   
    ex = speed*cos(angle);
    ey = speed*sin(angle);
    
    _position.x += ex;
    _position.y += ey;
    
    if(_position.x >= _target.x || _position.y >= _target.y){
      _direction.x = 0;
      _direction.y = 0;
    }else if(_position.x < _target.x){
      _direction.x = ex;      
    }else if(_position.y < _target.y){
      _direction.y = ey;
    }
    _life -= _fishDensity;
    _fishDensity = 0;
    if(_life < 0){
      _shouldDie = true;
    }
  }
  
  void draw(){
    
    float angle;
    
    angle = atan2(_direction.y, _direction.x);
    
    pushMatrix();
    
    rotate(angle);
    if(_direction.x > 0){
      scale(-0.5,0.5);
    }else{
      scale(0.5);
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
  void callCollidingEvent(EntityType type){}

  private PVector _position = new PVector();
  private PVector _direction = new PVector();
  private PVector _target = new PVector();
  private float _life = 1000;
  private float _fishDensity = 0;
  private boolean _shouldDie = false;
}
