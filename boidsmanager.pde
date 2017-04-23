class BoidsManager{
  BoidsManager(){
  }

  void update(PVector target, List<Fish> fishes){
    for(Fish fish: fishes){
      fish.target(target);
      fish.fishes(fishes);
      fish.calcVelocity();
    }
  }
}
