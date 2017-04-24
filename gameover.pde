class Gameover extends Scene{
  Gameover(){
    resources.trigger("gameover.mp3");
  }
  void update(){}
  void draw(){
    resources.draw("gameover.png", 0, 0);
  }
  Scene nextScene(){return(new Opening());}
  void mousePressed(){
    _isFinish = true;
  }
}