class Minion implements Entity, Fish{
  Minion(float x, float y){
    _position = new PVector(x, y);
    _velocity = new PVector(0, 0);

    _v1 = new PVector();
    _v2 = new PVector();
    _v3 = new PVector();
  }
  
  void update(){
  }
  
  void draw(){
    pushMatrix();
    scale(0.5);
    resources.draw("minion.png");
    popMatrix();
  }
  boolean shouldDie(){return false;}
  void die(){}

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

  void calcVelocity(){
    float r1 = 1.0;
    float r2 = 0.8;
    float r3 = 0.1;
    _v1 = calcCenter().mult(r1);
    _v2 = calcAvoid().mult(r2);
    _v3 = calcAverage().mult(r3);
    _velocity = _v1.add(_v2).add(_v3);
  }

  private PVector _position;
  private PVector _direction;

  private PVector _velocity;
  private List<Fish> _fishes;

  private PVector _v1 = new PVector();
  private PVector _v2 = new PVector();
  private PVector _v3 = new PVector();

  private PVector calcCenter(){
    float centerPullFactor = 300;
    PVector v = new PVector(0, 0);
    for(Fish fish : _fishes){
      if(this.equals(fish))continue;
      v = v.add(fish.position());
    }
    v = v.div(_fishes.size()- 1);
    v = (v.sub(this._position)).div(centerPullFactor);
    return v;
  }

  private PVector calcAvoid(){
    float distThreshold = 30;
    PVector v = new PVector(0, 0);
    for(Fish fish : _fishes){
      if(this.equals(fish))continue;
      if(fish.position().dist(this.position()) < distThreshold){
        v = v.sub(fish.position().sub(this.position()));
      }
    }
    return v;

  };
  private PVector calcAverage(){
    PVector v = new PVector(0, 0);
    for(Fish fish : _fishes){
      if(this.equals(fish))continue;
      v = v.add(fish.velocity());
    }

    v = v.div(_fishes.size()-1);
    v = (v.sub(this._velocity)).mult(0.5);
    return v;
  };
}
