class RoadCar extends Road {
  
  // Aplitude and offset to calculate the height of the columns.
  float amplitude, offset;
  // Whether or not an extra sin-function has to be added the the height of the columns.
  boolean sin;
  
  // Array of column on the side of the road.
  Column[] columns;

  RoadCar(PVector position) {
    super(position, new PVector(2 * width, 100, 0));

    amplitude = 100.0;
    offset = 1/100.0;
    sin = false;

    createColumns(4);
  }
  
  // Creates colunms every 'skip * precision' pixels.
  void createColumns(int skip) {
    columns = new Column[int(zValues.length / skip)];
    for (int i = 0; i < columns.length; i++) {
      float x = i * precision * skip;
      columns[i] = new Column(this, new PVector(x, size.y, 0), (float) i / columns.length * 100);
    }
  }

  void layoutRoad() {
    stroke(0);
    beginShape();
    rect(position.x, position.y, size.x, size.y);
    endShape();

    for (Column c : columns) {
      pushMatrix();
      translate(position.x, 0, 0);
      c.layoutColumn();
      popMatrix();
    }
  }

  void updateRoad() {
    // Adds near vehicles to the list of near vehicles of the column.
    for (Column c : columns) {
      for (Vehicle v : vehicles) {
        // Is on bridge & euclidian distance from column to vehicle is less than the influence radius of the columns.
        if (v.onBridge() &&  euclidianDistance(c.position, v.position) < Column.influenceRadius) {
          c.near.add(v);
        }
      }
    }
  }

  // Calculate height according to the given x position.
  float calculateZ(float x) {
    float z = cos(offset * (x - (PI / offset)/2)); // value: [-1, 1]

    // Extra curves.
    if (sin) {
      z += sin(2 * offset * x); // value: [-2, 2]
    }
    
    return amplitude * z; // value [-2a, 2a]
  }

  void addVehicle() {
    vehicles.add(new Car(this, new PVector(- random(size.x), random(18, size.y - 18), 0)));
    amount++;
  }
}
