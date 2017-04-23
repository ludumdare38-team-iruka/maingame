class Opening extends Scene{
  void update(){}
  void draw(){}
  Scene nextScene(){
    return(new Tutorial());
  }
  void mousePressed(){
    _isFinish = true;
  }
}
