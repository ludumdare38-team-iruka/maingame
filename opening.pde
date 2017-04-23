class Opening extends Scene{
  Opening(){
    resources.loop("title.mp3");
  }
  void update(){
  }
  void draw(){}
  Scene nextScene(){
    return(new Tutorial());
  }
  void mousePressed(){
    _isFinish = true;
  }
}