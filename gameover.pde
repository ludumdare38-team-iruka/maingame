class Gameover extends Scene{
  Gameover(int point){
    resources.trigger("gameover.mp3");
    _score = point;
  }
  void update(){}
  void draw(){
    resources.draw("gameover.png", 0, 0);
    pushMatrix();
    translate(450, height/2);
    scale(0.6);
    resources.draw("minion.png");
    popMatrix();
    
    drawScore();

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
    int x = 560;
    
    str = nf(score(), 3);
    life = str.split("");
    
    for(int i=0; i<str.length(); i++){
      pushMatrix();
      translate(x, height/2);
      scale(0.6);
      resources.draw(life[i] + ".png");
      popMatrix();
      
      x += 60;
    }
  }

}