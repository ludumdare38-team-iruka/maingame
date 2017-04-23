class Minion implements Entity, Fish{
  Minion(float x, float y){
    _position = new PVector(x, y);
    _velocity = new PVector(0, 0);

    _v1 = new PVector();
    _v2 = new PVector();
    _v3 = new PVector();
  }
  
  void update(){
    _position = PVector.add(_position, _velocity);
  }
  
  void draw(){
    float angle;
    if(_velocity.mag() < maxSpeed){
      angle = 0;
    }else{
      angle = _velocity.heading();
    }
    pushMatrix();
    rotate(angle);
    if(abs(degrees(angle)) >=90){
      scale(1, -1);
    }
    scale(0.2);
    resources.draw("minion.png");
    popMatrix();
  }
  boolean shouldDie(){return false;}
  void die(){}
  float life(){return 0;}
  float age(){return 0;}

  int width(){return 0;}
  int height(){return 0;}

  float x(){return _position.x;}
  float y(){return _position.y;}
  PVector position(){return _position;};
  PVector velocity(){return _velocity;};

  PVector direction(){return _direction;}
  
  EntityType type(){return EntityType.Minion;}

  void callCollidingEvent(EntityType type){}

  void fishes(List<Fish> arr){
    _fishes = arr;
  }

  void target(PVector p){
    _target = p;
  }

  void calcVelocity(){
    float r1 = 1.5;
    float r2 = 0.5;
    float r3 = 0.5;
    float r4 = 0.0;
    _v1 = PVector.mult(calcCenter(),r1);
    _v2 = PVector.mult(calcAvoid(),r2);
    _v3 = PVector.mult(calcAverage(),r3);

    PVector vTarget = new PVector();
    if(PVector.dist( _target, this._position) > 30){
      vTarget = PVector.sub(_target, this._position).normalize().mult(maxSpeed);
    }

    _velocity = PVector.add(_v1, _v2, _v3).add(vTarget);
  }

  private PVector _position;
  private PVector _direction;

  private PVector _velocity;
  private List<Fish> _fishes;

  private PVector _v1 = new PVector();
  private PVector _v2 = new PVector();
  private PVector _v3 = new PVector();
  private PVector _target;
  private int maxSpeed = 0;

  private PVector calcCenter(){
    float centerPullFactor = 300;
    PVector v = new PVector(0, 0);
    for(Fish fish : _fishes){
      if(this.equals(fish))continue;
      v.add(fish.position());
    }
    v.div(_fishes.size()- 1);
    v.sub(this._position).div(centerPullFactor);
    return v;
  }

  private PVector calcAvoid(){
    float distThreshold = 60;
    PVector v = new PVector(0, 0);
    for(Fish fish : _fishes){
      if(this.equals(fish))continue;
      float dist = PVector.dist(this._position, fish.position());
      if(dist < distThreshold){
        PVector direct = PVector.sub(fish.position(), this._position);
        PVector directNormal = new PVector();
        directNormal.set(direct).normalize();
        v.sub(PVector.mult(directNormal, -dist+distThreshold));
      }
    }
    return v;

  };
  private PVector calcAverage(){
    PVector v = new PVector(0, 0);
    for(Fish fish : _fishes){
      if(this.equals(fish))continue;
      v.add(fish.velocity());
    }

    v.div(_fishes.size()-1);
    v.sub(this._velocity).mult(0.5);
    return v;
  };
}
