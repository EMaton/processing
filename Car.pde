class Car extends Vehicle {
  
  // Vehicle Width
  static final int vehicleY = 18;
  
  // Car Color
  color c;
  
  Car(Road road, PVector position) {
    super(road, position, 10);
    
    // Random Color
    float r = random(255);
    if (r < 200 || random(1) < 0.8) {
      c = color(r, r, r);
    } else {
      c = color(r, r, 0);
    }
  }
  
  // Layout of the Car
  void layoutVehicle() {
    fill(c);
    translate(position.x, position.y, position.z + 9);
    box(46, vehicleY, 15);
  }
}
