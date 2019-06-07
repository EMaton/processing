// abstract class for all roads
abstract class Road {

  // Amount of vehicles on the road.
  int amount = 0;

  // Position & Size of the road.
  PVector position, size;

  // List of vehicles on the road.
  ArrayList<Vehicle> vehicles;

  // Height values of the road.
  float[] zValues;
  // Draw precision (for drawing meshes, every x pixels).
  int precision;

  Road(PVector position, PVector size) {
    this.position = position;
    this.size = size;

    // Add 10 vehicles.
    vehicles = new ArrayList();
    for (int i = 0; i < 10; i++) {
      addVehicle();
    }

    // Set default precision to 10 (e.g. every 10 pixels a mesh gets drawn).
    precision = 10;
    zValues = new float[(int)(size.x / precision) + 1];
  }

  // Adds a vehicle to the road based on its kind. Needs to add one to amount!
  abstract void addVehicle();

  // Removes the first vehicle in the list.
  void removeVehicle() {
    if (vehicles.size() > 0) {
      vehicles.remove(0);
      amount--;
    }
  }

  // Contains all the layout of the road (i.e. a plain with a stroke, ...).
  abstract void layoutRoad();

  // Rendering the road.
  void render() {
    pushStyle();
    layoutRoad();
    popStyle();

    // Renders all the vehicles.
    for (Vehicle v : vehicles) {
      pushMatrix();
      // Translate to zero-position of the road,
      // so the vehicles origin is left-top corner of the road.
      translate(position.x, position.y);
      v.render();
      popMatrix();
    }
  }

  // Contains the update step of road.
  abstract void updateRoad();

  // Euclidian distance between two points (2D).
  float euclidianDistance(PVector a, PVector b) {
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
  }

  // Updating the road.
  void update() {
    updateRoad();
    // Update all the vehicles.
    for (Vehicle v : vehicles) {
      v.update();
    }
  }

  // Returns the amount of vehicles on the road.
  int vehiclesOnRoad() {
    int count = 0;
    for (Vehicle v : vehicles) {
      if (v.onBridge()) count++;
    } 
    return count;
  }
}
