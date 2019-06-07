class Bike extends Vehicle {
  Bike(Road road, PVector position) {
    super(road, position, 5);
    this.size = new PVector(21, 5, 12);
  }

  // Layout of the bike.
  void layoutVehicle() {
    translate(position.x, position.y, position.z + size.z / 2 + 1 /* +1: not visible below road */);
    if (position.y < 0) {
      // Crossing the road.
      box(size.y, size.x, size.z);
    } else {
      box(size.x, size.y, size.z);
    }
  }

  void onRedLight() {
    float middle = road.size.x / 2 - 50;
    // If the bike is passed the crossing OR
    // before the crossing but the next position is not on the crossing.
    if (position.x > middle || (nextXPosition() < middle && position.x < middle)) {
      moveForward();
    } else {
      cross();
    }
  }

  void onGreenLight() {
    // If the y-position is bigger than 0 it is not crossing (the adjacent car roads have a negative y-position).
    if (position.y > 0) {
      moveForward();
    } else {
      cross();
    }
  }

  void cross() {
    // Road needs to be a bike road, and will be.
    if (road instanceof RoadBike) {
      RoadBike bikeRoad = (RoadBike) road;

      // Total distance to cross (sum of y-sizes of roads between).
      int crossDistance = 0;
      for (Road r : bikeRoad.between) {
        crossDistance += r.size.y;
      }
      
      position.y -= velocity;
      // If the bike has crossed all the roads, switch road.
      if (position.y < -crossDistance) {
        bikeRoad.crossedBikesToRemove.add(this);
      }
    }
  }
}
