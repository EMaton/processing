// abstract class for all roads
abstract class Road {
  
  // Amount of vehicles
  int amount;
  
  // Position & Size of Bridge/Road
  PVector position, size;
  
  // List of Vehicles
  ArrayList<Vehicle> vehicles;
  
  // Bridge Height Values
  float[] zValues;
  // Draw Precision
  int precision;
  
  Road(PVector position, PVector size) {
    this.position = position;
    this.size = size;
    
    // Add 10 Vehicles
    amount = 0;
    vehicles = new ArrayList();
    for (int i = 0; i < 10; i++) {
      addVehicle();
    }
    
    // Set Default Precision to 10
    precision = 10;
    zValues = new float[(int) (size.x / precision) + 1];
  }
  
  // Every Road has to implement these functions
  abstract void layoutRoad();
  abstract void addVehicle();
  abstract void removeVehicle();
  
  // Rendering Road
  void render() {
    pushStyle();
    layoutRoad();
    popStyle();
    
    // Renders all Vehicles
    for (Vehicle v: vehicles) {
      pushMatrix();
      // Translate to 0-Position of the Road,
      // so the vehicles origin is left-top corner of the Road
      translate(position.x, position.y);
      v.render(); 
      popMatrix();
    }
  }
  
  // Returns the Amount of Vehicles on the Road
  int vehiclesOnRoad() {
    int count = 0;
    for (Vehicle v: vehicles) {
      if (v.onBridge()) count++;
    } return count;
  }
}
