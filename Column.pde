class Column {
  RoadCar road;
  ArrayList<Vehicle> near = new ArrayList();
  
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
    for(Vehicle v: near) {
      sumVelocity += v.velocity / 2;
      
      float mult = (columnZ + road.a) / (road.a * road.vehiclesOnRoad() / road.amount) / multDivider;
      if (!Float.isNaN(mult)) {
        v.multiplier = mult + 1;
      }
    }
    sumVelocity /= 1.04;
    
    return columnZ + road.a + sumVelocity;
  }

  void layoutColumn() {
    strokeWeight(diameter);
    stroke(255, 0, 0);
    noFill();
    line(position.x, position.y, 0, position.x, position.y, columnZ());
  }
}
