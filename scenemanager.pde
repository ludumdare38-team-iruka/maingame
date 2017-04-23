abstract class Scene{
  boolean _isFinish = false;
  void update(){}
  void draw(){}
  boolean isFinish(){return _isFinish;}
  Scene nextScene(){return(new NullScene());}
  void keyPressed(){}
  void keyReleased(){}
  void mousePressed(){}
  void mouseReleased(){}
}
