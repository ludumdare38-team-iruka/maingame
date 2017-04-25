class JellyFish extends Enemy{
  JellyFish(float x, float y,float tx, float ty){
    super(x, y, tx, ty, "kurage.png");
    super._scale = 0.2;
    super._life = 50;
    super._maxLife = 50;
  }
}
