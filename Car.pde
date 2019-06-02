class Car extends Vehicle {

  // Vehicle Dimensions
  static final int vehicleX = 46;
  static final int vehicleY = 18;
  static final int vehicleZ = 15;

  Car(Road road, PVector position) {
    super(road, position, 10);
  }

  // Layout of the Car
  void layoutVehicle() {
    fill(c);
    translate(position.x, position.y, position.z + vehicleZ/2 + 1 /* +1: not visible below road */);
    box(vehicleX, vehicleY, vehicleZ);
  }

  void onRedLight() {
    float middle = road.size.x / 2 - 100;
    if (position.x > middle || (position.x + velocity * multiplier < middle && position.x < middle)) {
      moveForward();
    }
  }
  
  void onGreenLight() {
    moveForward();
  }
}
