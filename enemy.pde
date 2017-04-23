class Enemy implements Entity{  
  Enemy(float x, float y,float tx, float ty){
    _position = new PVector(x,y);
    _target = new PVector(tx,ty);
  }
  

  
  void update(){
    
    int speed = 2;
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
  boolean shouldDie(){return false;}
  void die(){}
  float life(){return 0;};
  float age(){return 0;};

  int width(){return 0;}
  int height(){return 0;}

  float x(){return _position.x;}
  float y(){return _position.y;}
  PVector position(){return _position;};
  PVector direction(){return _direction;};

  
  EntityType type(){return EntityType.Enemy;}
  void callCollidingEvent(EntityType type){}

  private PVector _position = new PVector();
  private PVector _direction = new PVector();
  private PVector _target = new PVector();
}
