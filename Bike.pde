class Bike extends Vehicle {
  
  // Vehicle Dimensions
  static final int vehicleX = 21;
  static final int vehicleY = 5;
  static final int vehicleZ = 12;
  
  Bike(Road road, PVector position) {
    super(road, position, 5);
  }
  
  // Layout of the Bike
  void layoutVehicle() {
    translate(position.x, position.y, position.z + vehicleZ / 2 + 1 /* +1: not visible below road */);
    box(vehicleX, vehicleY, vehicleZ);
  }
}
