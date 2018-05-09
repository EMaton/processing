class Bike extends Vehicle {
  
  // Vehicle Width
  static final int vehicleY = 5;
  
  Bike(Road road, PVector position) {
    super(road, position, 5);
  }
  
  // Layout of the Bike
  void layoutVehicle() {
    translate(position.x, position.y, position.z + 6);
    box(21, vehicleY, 12);
  }
}
