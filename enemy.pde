class Enemy implements Entity{
  Enemy(float x, float y,float tx, float ty, String imageName){
    _position = new PVector(x,y);
    _target = new PVector(tx,ty);
    this.imageName = imageName;
  }

  void update(){
    if(_status == EnemyStatus.Move){
      moving();
    }else if(_status == EnemyStatus.Escape){
      escape();
    }else{
      _status = EnemyStatus.Move;
    }

    if(_life < 0 && _status != EnemyStatus.Escape){
      _status = EnemyStatus.Escape;
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
      scale(-_scale, _scale);
    }else{
      scale(_scale);
    }
    resources.draw(imageName);
    popMatrix();
  }

  boolean shouldDie(){return _shouldDie;}
  void die(){_shouldDie = true;}
  float life(){return _life;}
  void life(float l){_life = l;}
  float age(){return _age;}

  int width(){return 50;}
  int height(){return 50;}

  float x(){return _position.x;}
  float y(){return _position.y;}

  PVector position(){return _position;}
  PVector direction(){return _direction;}

  EntityType type(){return EntityType.Enemy;}
  void callCollidingEvent(Entity entity){
    if(entity.type() == EntityType.Egg){
      _status = EnemyStatus.Stop;
    }
  }

  private PVector _position = new PVector();
  private PVector _direction = new PVector();
  private PVector _target = new PVector();
  private float _life = 200;
  private boolean _shouldDie = false;
  private float speed = 1.5;
  private float _scale = 0.3;
  private EnemyStatus _status = EnemyStatus.Move;
  private String imageName = "";
  private float _age= 0;
}

enum EnemyStatus{
  Move,
  Escape,
  Stop
}
