// abstract class for all roads
abstract class Road {

  // Amount of vehicles (for buttons)
  int amount = 0;

  // Position & Size of Bridge/Road
  PVector position, size;

  // List of Vehicles
  ArrayList<Vehicle> vehicles;

  // Bridge Height Values
  float[] zValues;
  // Draw Precision (for drawing meshes)
  int precision;

  Road(PVector position, PVector size) {
    this.position = position;
    this.size = size;

    // Add 10 Vehicles
    vehicles = new ArrayList();
    for (int i = 0; i < 10; i++) {
      addVehicle();
    }

    // Set Default Precision to 10
    precision = 10;
    zValues = new float[(int) (size.x / precision) + 1];
  }

  // Dependant on sub-class
  abstract void addVehicle();
  
  void removeVehicle() {
    if (vehicles.size() > 0) {
      vehicles.remove(0);
      amount--;
    }
  }
  
  // Every Road has to implement this function
  abstract void layoutRoad();

  // Rendering Road
  void render() {
    pushStyle();
    layoutRoad();
    popStyle();

    // Renders all Vehicles
    for (Vehicle v : vehicles) {
      pushMatrix();
      // Translate to 0-Position of the Road,
      // so the vehicles origin is left-top corner of the Road
      translate(position.x, position.y);
      v.render();
      popMatrix();
    }
  }
  
  // Every Road has to implement this function
  abstract void updateRoad();
  
  float euclidianDistance(PVector a, PVector b) {
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
  }

  void update() {
    updateRoad();
    for (Vehicle v : vehicles) {
      v.update();
    }
  }

  // Returns the Amount of Vehicles on the Road
  int vehiclesOnRoad() {
    int count = 0;
    for (Vehicle v : vehicles) {
      if (v.onBridge()) count++;
    } 
    return count;
  }
}
