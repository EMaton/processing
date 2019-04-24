class Car extends Vehicle {
  
  // Vehicle Width
  static final int vehicleY = 18;
  
  Car(Road road, PVector position) {
    super(road, position, 10);
  }
  
  // Layout of the Car
  void layoutVehicle() {
    fill(c);
    translate(position.x, position.y, position.z + 9);
    box(46, vehicleY, 15);
  }
}
