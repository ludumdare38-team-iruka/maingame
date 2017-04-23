abstract class Scene{
  boolean _isFinish = false;
  void update(){}
  void draw(){}
  boolean isFinish(){return _isFinish;}
  Scene nextScene(){return null;}
  void keyPressed(){}
  void keyReleased(){}
  void mousePressed(){}
  void mouseReleased(){}
}
