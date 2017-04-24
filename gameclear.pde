class Gameclear extends Scene{
  Gameclear(){
    resources.loop("clear.mp3");
  }
  void update(){}
  void draw(){
    resources.draw("gameclear.png",0,0);
  }
  void mousePressed(){
    resources.close("clear.mp3");
    _isFinish = true;
  }
}