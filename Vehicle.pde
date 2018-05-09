// abstract class for all vehicles
abstract class Vehicle {
  
  // Rarent Road
  Road road;
  // Rosition of the Vehicle
  PVector position;
  // Velocity
  float velocity;
  
  Vehicle(Road road, PVector position, float maxVelocity) {
    this.road = road;
    this.position = position;
    // Gives random Velocity between max/2 & max
    this.velocity = random(maxVelocity / 2, maxVelocity);
  }
  
  // Every Vehicle has to implement this function
  abstract void layoutVehicle();
  
  // Rendering Vehicle
  void render() {
    // Layout of the Vehicle
    pushStyle();
    layoutVehicle();
    popStyle();
    
    // x Movement
    position.x += velocity;
    if (position.x > 2 * road.size.x) position.x = - road.size.x;
    
    // z Movement
    if(onBridge()) {
      zPosition();
    } else {
      // Fall Movement
      if (position.z > 0) {
        position.z -= 10;
      } else {
        position.z = 0;
      }
    }
  }
  
  // Calculates zPosition
  // Gets overwriten in Pedestrian (two zValues!)
  void zPosition() {
    position.z = road.zValues[ceil(position.x / road.precision)];
  }
  
  // Returns true if Vehicle is on Bridge
  boolean onBridge() {
    return position.x >= 0 && position.x <= road.size.x;
  }
}
