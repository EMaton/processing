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
    if (position.y < 0) {
      box(vehicleY, vehicleX, vehicleZ);
    } else {
      box(vehicleX, vehicleY, vehicleZ);
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
