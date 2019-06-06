class RoadCar extends Road {

  float a, b;
  boolean sin;
  Column[] columns;

  RoadCar(PVector position) {
    super(position, new PVector(2 * width, 100, 0));

    a = 100.0;
    b = 1/100.0;

    sin = false;

    createColumns(4);
  }

  void createColumns(int skip) {
    columns = new Column[int(zValues.length / skip)];
    for (int i = 0; i < columns.length; i++) {
      float x = i * precision * skip;
      columns[i] = new Column(this, new PVector(x, size.y, 0), (float) i / columns.length * 100);
    }
  }

  // Layout of the Car Road
  void layoutRoad() {
    // Road
    stroke(0);
    beginShape();
    rect(position.x, position.y, size.x, size.y);
    endShape();

    // Draw Road
    for (Column c : columns) {
      pushMatrix();
      translate(position.x, 0, 0);
      c.layoutColumn();
      popMatrix();
    }
  }

  void updateRoad() {
    for (Column c : columns) {
      for (Vehicle v : vehicles) {
        // Euclidian Distance From Column to Vehicle
        if (v.onBridge() &&  euclidianDistance(c.position, v.position) < 100) {
          c.nearCars.add(v);
        }
      }
    }
  }

  // Calculate height according to the given x position.
  // Z always between -a and 3a.
  float calculateZ(float x) {
    // 0 and 2a
    float z = cos(b * (x - (PI / b)/2));

    // Extra Curve
    // -a and a
    if (sin) {
      z += sin(2 * b * x);
    }

    // -a and 3a
    return a * z;
  }

  // Adds a Vehicle
  void addVehicle() {
    vehicles.add(new Car(this, new PVector(- random(size.x), random(18, size.y - 18), 0)));
    amount++;
  }
}
