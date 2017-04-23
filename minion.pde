class Minion implements Entity, Fish{
  Minion(float x, float y){
    _position     = new PVector(x, y);
    // _velocity     = new PVector(random(-5, 5), -2);
    _velocity     = new PVector(5, -2);
    _acceleration = new PVector(0, 0);

    _v1 = new PVector();
    _v2 = new PVector();
    _v3 = new PVector();

    _radius = 0.0;
    _velocityLimit = 2;
    _forceLimit = 0.03;
  }
  
  void update(){
    _velocity.add(_acceleration);
    _velocity.limit(_velocityLimit);
    _position.add(_velocity);

    if(screenSize.x < _position.x){
      _position.x -= screenSize.x;
    }else if(_position.x < 0){
      _position.x += screenSize.x;
    }
    if(screenSize.y < _position.y){
      _position.y -= screenSize.y;
    }else if(_position.y < 0){
      _position.y += screenSize.y;
    }
  }
  
  void draw(){
    pushMatrix();
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

  void attraction(float p){
    _attraction = p;
  };

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
    float r1 = 1.0;
    float r2 = 3.5;
    float r3 = 4.0;
    float r4 = 0.0;
    PVector a1 = PVector.mult(calcCenter() ,r1);
    PVector a2 = PVector.mult(calcAvoid()  ,r2);
    PVector a3 = PVector.mult(calcAverage(),r3);

    // PVector aTarget = new PVector();
    // if(PVector.dist( _target, this._position) > 30){
    //   aTarget = PVector.sub(_target, this._position).normalize().mult(r4);
    // }

    _acceleration = PVector.add(a1, a2, a3).div(2.0f);

  }

  private PVector _position;
  private PVector _direction;
  private float _radius;

  private PVector _velocity;
  private PVector _acceleration;
  private List<Fish> _fishes;

  private PVector _v1 = new PVector();
  private PVector _v2 = new PVector();
  private PVector _v3 = new PVector();
  private PVector _target;
  private float _velocityLimit;
  private float _forceLimit;
  private float _attraction = 0;

  private PVector calcCenter(){
    float neighbordist = 70*_attraction;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Fish fish: _fishes) {
      if(this.equals(fish))continue;
      float d = PVector.dist(this._position, fish.position());
      if ((d > 0) && (d < neighbordist)) {
        sum.add(fish.position());
        count++;
      }
    }
    if (count > 0) {
      sum.div(float(count));
      return seek(sum);
    } 
    else {
      return new PVector(0, 0);
    }
  }

  private PVector calcAvoid(){
    float distThreshold = 50;
    PVector v = new PVector(0, 0);
    int count = 0;
    for(Fish fish : _fishes){
      if(this.equals(fish))continue;
      float dist = PVector.dist(this._position, fish.position());
      if(dist > 0 && dist < distThreshold){
        PVector direct = PVector.sub(fish.position(), this._position);
        PVector directNormal = new PVector();
        directNormal.set(direct).normalize();
        v.sub(PVector.div(directNormal, dist));
        count++;
      }
    }
    if(count > 0)v.div(float(count));
    return v;

  };
  private PVector calcAverage(){
    float neighbordist = 100;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Fish fish: _fishes) {
      float d = PVector.dist(_position, fish.position());
      if ((d > 0) && (d < neighbordist)) {
        sum.add(fish.velocity());
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(_velocityLimit);
      PVector steer = PVector.sub(sum, _velocity);
      steer.limit(_forceLimit);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  };

  private PVector seek(PVector target) {
    PVector desired = PVector.sub(_target, _position);  // A vector pointing from the position to the target
    if(desired.mag() > 200){
      desired = PVector.sub(target, _position);  // A vector pointing from the position to the target
    }
    // Scale to maximum speed
    desired.normalize();
    desired.mult(_velocityLimit);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, _velocity);
    steer.limit(_forceLimit);  // Limit to maximum steering force
    return steer;
  }
}
