interface Entity{
  void update();
  void draw();
  boolean shouldDie();
  void die();

  int width();
  int height();

  float x();
  float y();
  
  EntityType type();
  void callCollidingEvent(EntityType type);
}
