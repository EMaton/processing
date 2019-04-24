class RoadCar extends Road {

  float a, b;
  int skip;
  boolean sin;
  // float mult = 1;

  RoadCar(PVector position) {
    super(position, new PVector(2 * width, 100, 0));

    skip = 4;
    a = 100.0;
    b = 1/100.0;

    sin = false;
  }

  // Layout of the Car Road
  void layoutRoad() {
    // Road
    stroke(0);
    beginShape();
    rect(position.x, position.y, size.x, size.y);
    endShape();

    float a = this.a * vehiclesOnRoad() / amount;
    float p = PI / this.b;

    // Frames
    strokeWeight(10);
    stroke(255, 0, 0);
    noFill();
    beginShape();
    for (int j = 0; j < zValues.length; j++) {
      int x = j * precision;
      float z = calculateZ(x, a, p);

      vertex(position.x + x, size.y, z);

      // Frame 'Pillars'
      if (j % skip == 0) {
        vertex(position.x + x, size.y, 0);
        vertex(position.x + x, size.y, z);
      }
    }
    endShape();

    // TODO:
    //
    // - make multiplier (default value: 1) for height (z) => float z = multi * calcZ()
    // - make toggle for every color (r, g, b), turn on and off.
    // if (red && green && blue) {
    //    v.c = color(red, green, blue)
    // } else if (red && green & !blue) {
    //    v.c = color(red, green, 0)
    // } else if ...
    // OR
    // if (red) {
    //   if (green) {
    //     if (blue) {
    //        v.c = color(red, green, blue)
    //     } else {
    //        v.c = color(red, green, 0)
    //     }
    //   } else {}
    // } else {
    // }
    for (Vehicle v : vehicles) {
      float z = calculateZ(v.position.x, a, p);

      float red = z % 156 + 100;
      float green = 255 - z % 101;
      float blue = z;
      v.c = color(red, green, blue);
    }
  }

  // Calculate height according to the given x position.
  float calculateZ(float x, float a, float p) {
    float z = a * cos(this.b * (x - p/2)) + a;

    // Extra Curve
    if (sin) {
      z += a * sin(2 * this.b * x);
    }
    return z;
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
