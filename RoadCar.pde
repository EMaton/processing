class RoadCar extends Road {

  float a, b;
  int skip;
  boolean sin;
  float[] vehiclePositions;

  RoadCar(PVector position) {
    super(position, new PVector(2 * width, 100, 0));

    skip = 4;
    a = 100.0;
    b = 1/100.0;

    sin = false;

    vehiclePositions = new float[zValues.length];
  }

  // Layout of the Car Road
  void layoutRoad() {
    float a = this.a * vehiclesOnRoad() / amount;
    float p = PI / this.b;

    for (Vehicle v : vehicles) {
      if (v.onBridge()) {
        float z = calculateZ(int(v.position.x / 10), v.position.x, a, p);

        float red = z % 156 + 100;
        float green = 255 - z % 101;
        float blue = z;
        v.c = color(red, green, blue);

        float multi = z/a + 1;
        if (!Float.isNaN(multi)) {
          v.multiplier = multi;
        }

        // vehiclePositions[int(v.position.x / 10)] += v.velocity / 2;
        int previousIdx = int((v.position.x - v.multiplier * v.velocity) / 10);
        int currentIdx = int(v.position.x / 10);
        for (int j = previousIdx; j <= currentIdx; j++) {
          // Because velocity can have increase so that the previous position is BEFORE the bridge.
          if (0 <= j) {
          vehiclePositions[j] += v.velocity;
          }
        }
      }
    }

    // Road
    stroke(0);
    beginShape();
    rect(position.x, position.y, size.x, size.y);
    endShape();

    // Frames
    strokeWeight(10);
    stroke(255, 0, 0);
    noFill();
    beginShape();
    for (int j = 0; j < zValues.length; j++) {
      int x = j * precision;
      float z = calculateZ(j, x, a, p);

      vertex(position.x + x, size.y, z);

      // Frame 'Pillars'
      if (j % skip == 0) {
        vertex(position.x + x, size.y, 0);
        vertex(position.x + x, size.y, z);
      }
    }
    endShape();

    for (int j = 0; j < vehiclePositions.length; j++) {
      // TODO: add slider 'influence' just from 1 to 1.10.
      vehiclePositions[j] /= 1.05;
    }
  }

  // Calculate height according to the given x position.
  // Z always between -a and 3a.
  float calculateZ(int idx, float x, float a, float p) {
    // 0 and 2a
    float z = a * cos(this.b * (x - p/2)) + a;

    // Extra Curve
    // -a and a
    if (sin) {
      z += a * sin(2 * this.b * x);
    }

    // -a and 3a
    return z + vehiclePositions[idx];
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
