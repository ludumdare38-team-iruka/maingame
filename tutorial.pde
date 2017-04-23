class Tutorial extends Scene{
  void update(){}
  void draw(){}
  Scene nextScene(){
    return(new Game());
  }
  void mousePressed(){
    _isFinish = true;
  }
}
