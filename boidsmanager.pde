class BoidsManager{
  BoidsManager(){
  }

  void update(List<Fish> fishes){
    for(Fish fish: fishes){
      fish.fishes(fishes);
      fish.calcVelocity();
    }
  }
}
