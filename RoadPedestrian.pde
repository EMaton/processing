class RoadPedestrian extends Road {

  // Height values of the second road.
  float[] zValues2;

  // Aplitude and offset to calculate the height of roads.
  float amplitude1, offset1;
  float amplitude2, offset2;

  // The car road that the vehicles have influence on.
  RoadCar roadCar;

  RoadPedestrian(PVector position, RoadCar road) {
    super(position, new PVector(2 * width, 10, 0));
    this.roadCar = road;

    amplitude1 = 100.0;
    offset1 = 1/100.0;

    amplitude2 = 100.0;
    offset2 = 1/100.0;

    // Change zValues to higher precision (visible otherwise while rendering).
    precision = 5;
    zValues = new float[(int) (size.x / precision) + 1];
    zValues2 = new float[(int) (size.x / precision) + 1];
  }

  void layoutRoad() {
    noStroke();
    fill(120);
    for (int i = 1; i < zValues.length; i++) {
      // Fist road.
      beginShape();
      // Order is important!
      vertex(position.x + (i - 1) * precision, position.y, zValues[i - 1]);           // LEFT TOP
      vertex(position.x + (i - 1) * precision, position.y + size.y, zValues[i - 1]);  // LEFT BOTTOM

      vertex(position.x + i * precision, position.y + size.y, zValues[i]);            // RIGHT BOTTOM
      vertex(position.x + i * precision, position.y, zValues[i]);                     // RIGHT TOP
      endShape();

      // Second road (same as first road, other zValues).
      beginShape();
      vertex(position.x + (i - 1) * precision, position.y + size.y, zValues2[i - 1]);
      vertex(position.x + (i - 1) * precision, position.y + 2 * size.y, zValues2[i - 1]);

      vertex(position.x + i * precision, position.y + 2 * size.y, zValues2[i]);
      vertex(position.x + i * precision, position.y + size.y, zValues2[i]);
      endShape();
    }
  }

  void updateRoad() {
    // Influence of vehicles on columns.
    for (Column c : roadCar.columns) {
      for (Vehicle v : vehicles) {
        // Is on bridge & euclidian distance from column to vehicle is less than the influence radius of the columns.
        if (v.onBridge() &&  euclidianDistance(c.position, v.position) < 100) {
          c.influence.add(v);
        }
      }
    }

    float period1 = PI / offset1;
    float period2 = PI / offset2;

    // Amount of arcs.
    int arcs1 = (int) Math.floor(size.x / period1);
    int arcs2 = (int) Math.floor(size.x / period2);
    
    // Amount of steps before and after: left space.
    int space1 = (int) (size.x - period1 * arcs1) / 2;
    int space2 = (int) (size.x - period2 * arcs2) / 2;
    // NOTE: this is important so the road to not end in the air.
    // If no arc fits the height will just be 0 for the remaining space.

    // Calculating zValues.
    for (int j = 0; j < zValues.length; j++) {
      int x = j * precision;

      // First road.
      if (j <= space1 / precision || j > zValues.length - space1 / precision) {
        zValues[j] = 0;
      } else {
        zValues[j] = amplitude1 * sin(offset1 * (x - space1));
      }

      // Second road.
      if (j <= space2 / precision || j > zValues.length - space2 / precision) {
        zValues2[j] = 0;
      } else {
        zValues2[j] = amplitude2 * cos(offset2 * (x + period2/2 - space2));
      }
    }
  }

  void addVehicle() {
    float y;
    // 50% chance to end up on either road.
    if (random(1) < 0.5) {
      y = random(2.5, size.y - 2.5);
    } else {
      y = random(size.y + 2.5, 2 * size.y - 2.5);
    }

    vehicles.add(new Pedestrian(this, new PVector(- random(size.x / 4), y, 0)));
    amount++;
  }
}
