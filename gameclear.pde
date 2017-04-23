class Gameclear extends Scene{
  void update(){}
  void draw(){
    resources.draw("gameclear.png",0,0);
  }
  boolean isFinish(){return true;}
}