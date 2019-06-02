class Pedestrian extends Vehicle {
  
  // Vehicle Dimensions
  static final int vehicleX = 5;
  static final int vehicleY = 5;
  static final int vehicleZ = 17;
  
  Pedestrian(Road road, PVector position) {
    super(road, position, 2);
  }
  
  // Layout of the Car
  void layoutVehicle() {
    translate(position.x, position.y, position.z + vehicleZ/2 /* +1: not visible below road */);
    box(vehicleX, vehicleY, vehicleZ);
  }
  
  void onRedLight() {
    moveForward();
  }
  
  void onGreenLight() {
    moveForward();
  }
  
  // Overrides function from superclass (special case, two roads)
  void zPosition() {
    // z-Position in function of the y-Position
    if (position.y < road.size.y) {
      super.zPosition();
    } else {
      // You need to cast '(RoadPedestrian) road' 
      // because Road itself has no zValues2[], only RoadPedestrian
      if (road instanceof RoadPedestrian) {
        // Convert abstract road to a more specific type, e.g. RoadPedestrian
        RoadPedestrian pedestrianRoad = ((RoadPedestrian) road);
        position.z = pedestrianRoad.zValues2[ceil(position.x / road.precision)];
      } else {
        // fail safe: it is possible to store other types of road in the variable road...
        super.zPosition();
      }
    }
  }
}
