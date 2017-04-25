class Maguro extends Enemy{
  Maguro(float x, float y,float tx, float ty){
    super(x, y, tx, ty, "maguro.png");
    super._scale = 0.3;
    super._life = 200;
    super._maxLife = 200;
  }
}
