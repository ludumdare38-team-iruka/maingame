class Opening extends Scene{
  Opening(){
    resources.loop("title.mp3");
  }
  void update(){
  }
  void draw(){
    resources.draw("title.png",0,0);
    pushMatrix();
    translate(640,580);
    if(frameCount%60 != 0 && frameCount%60 != 1 && frameCount%60 != 2){
      resources.draw("gamestart.png");
    }
      
    popMatrix();
  }
  Scene nextScene(){
    return(new Tutorial());
  }
  void mousePressed(){
    _isFinish = true;
  }
}