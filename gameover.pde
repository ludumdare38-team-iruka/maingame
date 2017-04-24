class Gameover extends Scene{
  Gameover(int point){
    resources.trigger("gameover.mp3");
    _score = point;
  }
  void update(){}
  void draw(){
    resources.draw("gameover.png", 0, 0);
    pushMatrix();
    translate(520, height/2);
    scale(0.6);
    resources.draw("egg.png");
    drawScore();
    popMatrix();

  }
  Scene nextScene(){return(new Opening());}
  void mousePressed(){
    _isFinish = true;
  }
  int score(){return _score;}
  
  private int _score;

  private void drawScore(){
    String str;
    String[] life;
    
    str = nf(score(), 3);
    life = str.split("");
    
    for(int i=0; i<str.length(); i++){
      if(i == 0){
        translate(150, 0);
      }else if(i == 1){
        translate(100, 0);
      }else if(i == 2){
        translate(100, 0);
      }
      resources.draw(life[i] + ".png");
    }
  }

}