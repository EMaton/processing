class Car extends Vehicle {
  Car(Road road, PVector position) {
    super(road, position, 10);
    this.size = new PVector(46, 18, 15);
  }

  // Layout of the the car.
  void layoutVehicle() {
    if (overlapsWithOtherVehicle(position)) {
      fill(255, 0, 0);
    } else {
      if (partyMode) {
        // HSB (hue, saturation, brightness), only hue needs to be changed to get another color.
        colorMode(HSB, 100);
        stroke(col, 100, 100);
        fill(100 - col, 100, 100);
        colorMode(RGB, 256);
      }
    }
    
    if (!onBridge()) {
      stroke(0);
      fill(255);
    }
    
    translate(position.x, position.y, position.z + size.z/2 + 1 /* +1: not visible below road */);
    box(size.x, size.y, size.z);
  }

  void onRedLight() {
    // If the car does not overlap with another vehicle on its next position OR
    // it does overlap in its current position (needs to move to resolve overlap).
    if (!overlapsWithOtherVehicle(new PVector(nextXPosition(), position.y, position.z)) || overlapsWithOtherVehicle(position)) {
      float middle = road.size.x / 2 - 100;
      // If the car is passed the crossing OR
      // before the crossing but the next position is not on the crossing.
      if (position.x > middle || (nextXPosition() < middle && position.x < middle)) {
        moveForward();
      }
      // else do nothing (e.g. stop).
    }
  }

  void onGreenLight() {
    // See onRedLight()
    if (!overlapsWithOtherVehicle(new PVector(nextXPosition(), position.y, position.z))|| overlapsWithOtherVehicle(position)) {
      moveForward();
    }
  }
}
