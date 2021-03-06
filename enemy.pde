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
    _age++;
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
    _angle = _angle + atan2(_direction.y, _direction.x);
    if(_status == EnemyStatus.Escape)_angle+=sin(_age*0.8)*0.2;

    pushMatrix();

    rotate(_angle);
    if(_direction.x > 0){
      scale(-_scale, _scale);
    }else{
      scale(_scale);
    }
    resources.draw(imageName);
    popMatrix();

    _angle = 0;;
  }

  boolean shouldDie(){return _shouldDie;}
  void die(){_shouldDie = true;}
  float life(){return _life;}
  void life(float l){_life = l;}
  float maxLife(){return _maxLife;}
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

    if(entity.type() == EntityType.Player){
      // _status = EnemyStatus.Stop;
      if(_status != EnemyStatus.Escape)_angle+=sin(_age*0.8)*0.2;
    }
  }

  protected PVector _position = new PVector();
  protected PVector _direction = new PVector();
  protected PVector _target = new PVector();
  protected float _life = 200;
  protected boolean _shouldDie = false;
  protected float speed = 1.5;
  protected float _scale = 0.3;
  protected EnemyStatus _status = EnemyStatus.Move;
  protected String imageName = "";
  protected float _age= 0;
  protected float _angle = 0;
  protected float _maxLife = 200;
}

enum EnemyStatus{
  Move,
  Escape,
  Stop
}
