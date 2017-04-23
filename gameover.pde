class Gameover extends Scene{
  void update(){}
  void draw(){
    resources.draw("gameover.png", 0, 0);
  }
  void mousePressed(){
    _isFinish = true;
  }
}