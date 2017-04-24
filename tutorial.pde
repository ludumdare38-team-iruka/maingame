class Tutorial extends Scene{
  void update(){}
  void draw(){
    resources.draw("tutorial.png", 0, 0);
  }
  Scene nextScene(){
    return(new Game());
  }
  void mousePressed(){
    resources.close("title.mp3");
    _isFinish = true;
  }
}