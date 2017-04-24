class Credit extends Scene{
  Credit(){
    resources.trigger("SE-4.mp3");
  }
  void update(){}
  void draw(){
    resources.draw("credit.png",0,0);
  }
  void mousePressed(){
    _isFinish = true;
  }
}