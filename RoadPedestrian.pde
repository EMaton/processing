class RoadPedestrian extends Road {

  float[] zValues2;
  float a1, b1;
  float a2, b2;

  RoadCar roadCar;

  RoadPedestrian(PVector position, RoadCar road) {
    super(position, new PVector(2 * width, 10, 0));
    this.roadCar = road;

    // Change z-Values
    precision = 5;
    zValues = new float[(int) (size.x / precision) + 1];
    zValues2 = new float[(int) (size.x / precision) + 1];

    // a * sin(b * x)
    // p = half period
    a1 = 100.0; // aplitude
    b1 = 1/100.0; // offset

    a2 = 100.0;
    b2 = 1/100.0;
  }

  void layoutRoad() {
    noStroke();
    fill(120);
    for (int i = 1; i < zValues.length; i++) {
      // Road 1
      beginShape();
      vertex(position.x + (i - 1) * precision, position.y, zValues[i - 1]);
      vertex(position.x + (i - 1) * precision, position.y + size.y, zValues[i - 1]);

      vertex(position.x + i * precision, position.y + size.y, zValues[i]);
      vertex(position.x + i * precision, position.y, zValues[i]);
      endShape();

      // Road 2
      beginShape();
      vertex(position.x + (i - 1) * precision, position.y + size.y, zValues2[i - 1]);
      vertex(position.x + (i - 1) * precision, position.y + 2 * size.y, zValues2[i - 1]);

      vertex(position.x + i * precision, position.y + 2 * size.y, zValues2[i]);
      vertex(position.x + i * precision, position.y + size.y, zValues2[i]);
      endShape();
    }
  }

  void updateRoad() {
    for (Column c : roadCar.columns) {
      for (Vehicle v : vehicles) {
        // Euclidian Distance From Column to Vehicle
        if (v.onBridge() &&  euclidianDistance(c.position, v.position) < 100) {
          c.nearVehicles.add(v);
        }
      }
    }
    
    float p1 = PI / b1; // period
    float p2 = PI / b2;

    // Amount of Arcs
    int arcs1 = (int) Math.floor(size.x / p1);
    int arcs2 = (int) Math.floor(size.x / p2);
    // Steps before and after: left Space
    int space1 = (int) (size.x - p1 * arcs1) / 2;
    int space2 = (int) (size.x - p2 * arcs2) / 2;

    // Calculating zValues
    for (int j = 0; j < zValues.length; j++) {
      int x = j * precision;

      // First Bridge
      if (j <= space1 / precision || j > zValues.length - space1 / precision) {
        zValues[j] = 0;
      } else {
        zValues[j] = a1 * sin(b1 * (x - space1));
      }

      // Second Brigde
      if (j <= space2 / precision || j > zValues.length - space2 / precision) {
        zValues2[j] = 0;
      } else {
        zValues2[j] = a2 * cos(b2 * (x + p2/2 - space2));
      }
    }
  }

  // Addss a Vehicle
  void addVehicle() {
    float y;
    if (random(1) < 0.5) {
      y = random(2.5, size.y - 2.5);
    } else {
      y = random(size.y + 2.5, 2 * size.y - 2.5);
    }

    vehicles.add(new Pedestrian(this, new PVector(- random(size.x / 4), y, 0)));
    amount++;
  }
}
