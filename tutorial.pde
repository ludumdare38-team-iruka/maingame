class Tutorial extends Scene{
  void update(){}
  void draw(){}
  Scene nextScene(){
    return(new Game());
  }
  void mousePressed(){
    resources.close("title.mp3");
    _isFinish = true;
  }
}