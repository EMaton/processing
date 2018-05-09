class RoadCar extends Road {
  
  float a, b;
  int skip;
  boolean sin;
  
  RoadCar(PVector position) {
    super(position, new PVector(2 * width, 100, 0));
    
    skip = 4;
    a = 100.0;
    b = 1/100.0;
    
    sin = false;
  }
  
  // Layout of the Car Road
  void layoutRoad() {
    // Road
    stroke(0);
    beginShape();
    rect(position.x, position.y, size.x, size.y);
    endShape();
    
    float a = this.a * vehiclesOnRoad() / amount;
    float p = PI / b;
    
    // Frames
    strokeWeight(10);
    stroke(255, 0, 0);
    noFill();
    beginShape();
    for (int j = 0; j < zValues.length; j++) {
      int x = j * precision;
      float z = a * cos(b * (x - p/2)) + a;
      
      // Extra Curve
      if (sin) {
        z += a * sin(2 * b * x);
      }
      
      vertex(position.x + x, size.y, z);
      
      // Frame 'Pillars'
      if (j % skip == 0) {
        vertex(position.x + x, size.y, 0);
        vertex(position.x + x, size.y, z);
      }
    }
    endShape();
  }
  
  // Adds a Vehicle
  void addVehicle() {
    vehicles.add(new Car(this, new PVector(- random(size.x), random(Car.vehicleY, size.y - Car.vehicleY), 0)));
    amount++;
  }
  
  // Removes a Vehicle
  void removeVehicle() {
    if (vehicles.size() > 0) {
      vehicles.remove(0);
      amount--;
    }
  }
}
