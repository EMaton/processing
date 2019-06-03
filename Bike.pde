class Bike extends Vehicle {
  Bike(Road road, PVector position) {
    super(road, position, 5);
    this.size = new PVector(21, 5, 12);
  }
  
  PVector getSize() {
    return new PVector(size.x, size.y, size.z);
  }

  // Layout of the Bike
  void layoutVehicle() {
    translate(position.x, position.y, position.z + size.z / 2 + 1 /* +1: not visible below road */);
    if (position.y < 0) {
      box(size.y, size.x, size.z);
    } else {
      box(size.x, size.y, size.z);
    }
  }

  void onRedLight() {
    float middle = road.size.x / 2 - 50;
    if (position.x > middle || (position.x + velocity * multiplier < middle && position.x < middle)) {
      moveForward();
    } else {
      cross();
    }
  }

  void onGreenLight() {
    if (position.y > 0) {
      moveForward();
    } else {
      cross();
    }
  }

  void cross() {
    RoadBike bikeRoad = (RoadBike) road;

    int crossDistance = 0;
    for (Road r : bikeRoad.between) {
      crossDistance += r.size.y;
    }
    position.y += - velocity;
    if (position.y < - crossDistance) {
      bikeRoad.crossedBikesToRemove.add(this);
    }
  }
}
