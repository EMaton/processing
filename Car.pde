class Car extends Vehicle {

  Car(Road road, PVector position) {
    super(road, position, 10);
    this.size = new PVector(46, 18, 15);
  }

  // Layout of the Car
  void layoutVehicle() {
    if (overlapsWithOtherVehicle(position)) {
      fill(255, 0, 0);
    } else {
      if (partyMode) {
        colorMode(HSB, 100); // for the rainbows
        stroke(col, 100, 100);
        fill(100 - col, 100, 100);
        colorMode(RGB, 256); // for the rainbows
      }
    }
    translate(position.x, position.y, position.z + size.z/2 + 1 /* +1: not visible below road */);
    box(size.x, size.y, size.z);
  }

  void onRedLight() {
    if (!overlapsWithOtherVehicle(new PVector(nextXPosition(), position.y, position.z)) || overlapsWithOtherVehicle(position)) {
      float middle = road.size.x / 2 - 100;
      if (position.x > middle || (position.x + velocity * multiplier < middle && position.x < middle)) {
        moveForward();
      }
    }
  }

  void onGreenLight() {
    if (!overlapsWithOtherVehicle(new PVector(nextXPosition(), position.y, position.z))|| overlapsWithOtherVehicle(position)) {
      moveForward();
    }
  }
}
