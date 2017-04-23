interface Fish extends Entity{
  PVector direction();
  void fishes(List<Fish> arr);
  PVector velocity();
  void calcVelocity();
  void target(PVector p);
  void attraction(float p);
}
