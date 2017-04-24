interface Entity{
  void update();
  void draw();
  boolean shouldDie();
  void die();
  float life();
  float age();

  int width();
  int height();

  float x();
  float y();
  PVector position();
  
  EntityType type();
  void callCollidingEvent(Entity entity);
}
