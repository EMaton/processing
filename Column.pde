class Column {
  RoadCar road;
  ArrayList<Vehicle> nearVehicles = new ArrayList();
  ArrayList<Vehicle> nearCars = new ArrayList();

  final PVector position;
  static final float diameter = 10;
  static final int multDivider = 10;

  float sumVelocity = 0;

  Column(RoadCar road, PVector position) {
    this.road = road;
    this.position = position;
  }

  float columnZ() {
    float columnZ = road.calculateZ(position.x);
    for (Vehicle v : nearVehicles) {
      sumVelocity += v.velocity;
    }
    nearVehicles.clear();
    sumVelocity /= 1.04;
    
    for (Vehicle v : nearCars) {
      float mult = (columnZ + road.a) / (road.a * road.vehiclesOnRoad() / road.amount) / multDivider;
      if (!Float.isNaN(mult) && mult < 100) {
        v.multiplier = mult + 1;
      }
    }
    nearCars.clear();

    return columnZ + road.a + sumVelocity;
  }

  void layoutColumn() {
    strokeWeight(diameter);
    stroke(255, 0, 0);
    noFill();
    float middle = road.size.x / 2;
    if (!(isRedLight && position.x > middle - 100 && position.x < middle + 100)) {
      line(position.x, position.y, 0, position.x, position.y, columnZ());
    } else {
      // columnZ reads and clear list of near vehicles.
      columnZ();
    }
  }
}
