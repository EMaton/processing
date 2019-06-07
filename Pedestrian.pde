class Pedestrian extends Vehicle {
  Pedestrian(Road road, PVector position) {
    super(road, position, 2);
    this.size = new PVector(5, 5, 17);
  }
  
  // Layout of the pedestrian.
  void layoutVehicle() {
    translate(position.x, position.y, position.z + size.z/2 /* +1: not visible below road */);
    box(size.x, size.y, size.z);
  }
  
  void onRedLight() {
    moveForward();
  }
  
  void onGreenLight() {
    moveForward();
  }
  
  // Overrides zPosition from super-class (special case, two roads).
  void zPosition() {
    // If on the left road.
    if (position.y < road.size.y) {
      super.zPosition();
    } else {
      // You need to cast '(RoadPedestrian) road' 
      // because Road itself has no zValues2[], only RoadPedestrian has.
      if (road instanceof RoadPedestrian) {
        // Convert abstract road to a more specific type, e.g. RoadPedestrian
        RoadPedestrian pedestrianRoad = ((RoadPedestrian) road);
        position.z = pedestrianRoad.zValues2[ceil(position.x / road.precision)];
      }
    }
  }
}
