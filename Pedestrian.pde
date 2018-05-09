class Pedestrian extends Vehicle {
  
  // Vehicle Width
  static final int vehicleY = 5;
  
  Pedestrian(Road road, PVector position) {
    super(road, position, 2);
  }
  
  // Layout of the Car
  void layoutVehicle() {
    translate(position.x, position.y, position.z + 9);
    box(5, vehicleY, 17);
  }
  
  // Overrides function from superclass (special case, two roads)
  @Override
  void zPosition() {
    // z-Position in function of the y-Position
    if (position.y < road.size.y) {
      position.z = road.zValues[ceil(position.x / road.precision)];
    } else {
      // You need to cast '(RoadPedestrian) road' 
      // because Road itself has no zValues2[], only RoadPedestrian
      position.z = ((RoadPedestrian) road).zValues2[ceil(position.x / road.precision)];
    }
  }
}
