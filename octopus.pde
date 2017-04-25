class Octopus extends Enemy{
  Octopus(float x, float y,float tx, float ty){
    super(x, y, tx, ty, "tako1.png");
    super._scale = 0.3;
    super._life = 100;
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
    if(_age%30 < 15){
      resources.draw("tako1.png");
    }else{
      resources.draw("tako2.png");
    }
    popMatrix();

    _angle = 0;;
  }
}
