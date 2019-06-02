// abstract class for all vehicles
abstract class Vehicle {

  // The Road it is driving on.
  Road road;
  // Position of the Vehicle
  PVector position;
  // Color of the Vehicle
  color c = color(255);
  // Velocity
  final float velocity;
  // Multiplier of the Velocity
  float multiplier = 1;

  Vehicle(Road road, PVector position, float maxVelocity) {
    this.road = road;
    this.position = position;
    // Gives a random velocity between max/2 & max
    this.velocity = random(maxVelocity / 2, maxVelocity);
  }

  // Every Vehicle has to implement this function.
  abstract void layoutVehicle();

  // Rendering Vehicle
  void render() {
    // Layout of the Vehicle
    pushStyle();
    layoutVehicle();
    popStyle();
  }

  abstract void onRedLight();
  abstract void onGreenLight();

  void moveForward() {
    // x Movement
    position.x += multiplier * velocity;
    // Reset after reaching the end.
    if (position.x > 2 * road.size.x) {
      position.x = - road.size.x;
    }
  }

  // Updating Vehicle
  void update() {
    // If 'Green': OK
    // If 'Red' and before half and next step also: OK
    if (!isRedLight) {
      onGreenLight();
    } else {
      onRedLight();
    }

    // y Movement

    // z Movement
    if (onBridge()) {
      zPosition();
    } else {
      position.z = 0;
    }
  }

  // Calculates zPosition
  // Gets overwriten in Pedestrian (two zValues!)
  void zPosition() {
    position.z = road.zValues[ceil(position.x / road.precision)];
  }

  // Returns true if Vehicle is on the Bridge
  boolean onBridge() {
    return position.x >= 0 && position.x <= road.size.x;
  }
}
