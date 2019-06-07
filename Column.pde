class Column {

  // Radius vehicles need to be in to be near.
  static final float influenceRadius = 100;

  // Diameter of a column.
  static final float diameter = 10;

  // The road is is part of.
  RoadCar road;

  // List of vehicles that have influence on its height.
  ArrayList<Vehicle> influence = new ArrayList();

  // List of vehicles that are near and influenced by the columns itself.
  ArrayList<Vehicle> near = new ArrayList();

  // Position of the column.
  final PVector position;

  float extraHeight = 0;

  // Color of the column.
  float col;

  Column(RoadCar road, PVector position, float c) {
    this.road = road;
    this.position = position;
    this.col = c;
  }
  
  // columnZ reads and clear list of near vehicles.
  float columnZ() {
    for (Vehicle v : influence) {
      extraHeight += v.velocity;
    }
    influence.clear();
    
    extraHeight /= 1.04;
    // NOTE: this is because it does not get reset to 0, possible to link to a GUI slider.

    float baseHeight = road.calculateZ(position.x) + 2 * road.amplitude;
    for (Vehicle vehicle : near) {
      // The percentage of vehicles on the road.
      float vehicleRatio = (float) road.vehiclesOnRoad() / road.amount;
      
      float mult = baseHeight / (vehicleRatio * road.amplitude * 10);
      // NOTE: why amplitude? because the baseHeight would be between ~[0, 4*amplitude], so dividing by the aplitude
      // would give you ~[0, 4] which is still to high. by deviding it with 10 we get reasonable accelerations.
      if (!Float.isNaN(mult) && mult < 5) {
        vehicle.multiplier = mult + 1;
      }
      // Same color as column.
      vehicle.col = col;
    }
    near.clear();

    return baseHeight + extraHeight;
  }

  void layoutColumn() {
    noFill();
    strokeWeight(diameter);
    
    if (partyMode) {
      colorMode(HSB, 100); // for the rainbows
      stroke(col, 100, 100);
      colorMode(RGB, 256); // for the rainbows
    } else {
      stroke(255, 0, 0);
    }
    
    float z = columnZ();
    // NOTE: needs to be called every frame, otherwise near does not get cleared.
    float middle = road.size.x / 2;
    if (!(isRedLight && position.x > middle - 100 && position.x < middle + 100)) {
      line(position.x, position.y, 0, position.x, position.y, z);
    }
  }
}
