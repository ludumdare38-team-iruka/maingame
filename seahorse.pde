class Seahorse extends Enemy{
  Seahorse(float x, float y,float tx, float ty){
    super(x, y, tx, ty, "seahorse.png");
    super._scale = 0.6;
    super._life = 150;
  }
}
