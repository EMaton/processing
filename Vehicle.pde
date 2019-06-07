// Abstract class for all vehicles (e.g. Pedestrial, Bike and Car)
abstract class Vehicle {
  // NOTE: Abstract classes and methods are declared with the 'abstract' keyword. 
  // Abstract classes can only be extended, and cannot be directly instantiated. 

  // The road it is driving on.
  Road road;

  // Position &^of the vehicle.
  PVector position, size;
  // Velocity
  final float velocity;

  // Color of the Vehicle.
  float col;
  // Multiplier of the velocity (used to mimic accelerations).
  float multiplier = 1;

  Vehicle(Road road, PVector position, float maxVelocity) {
    this.road = road;
    this.position = position;
    // a random velocity between max/2 & max
    this.velocity = random(maxVelocity / 2, maxVelocity);
  }

  // Contains all the layout of the vehicle (i.e. a box with a fill, ...).
  abstract void layoutVehicle();

  // Rendering the vehicle.
  void render() {
    pushStyle();
    layoutVehicle();
    popStyle();
  }

  // Contains the update step when the trafic light is red.
  abstract void onRedLight();
  // Contains the update step when the trafic light is green.
  abstract void onGreenLight();

  // Moves the vehicle to the next x-position and resets if it has reached the end.
  void moveForward() {
    position.x = nextXPosition();
    // Reset after reaching 2 * length of the road it drives on.
    if (position.x > 2 * road.size.x) {
      position.x = - road.size.x;
    }
  }

  // Calculates the next x-position based on the velocity and its multiplier.
  float nextXPosition() {
    return position.x + multiplier * velocity;
  }


  // Updating the vehicle.
  void update() {
    // Calls corresponding update functions based on the trafic light.
    if (!isRedLight) {
      onGreenLight();
    } else {
      onRedLight();
    }

    // If on the bridge it has to follow the z-position of the road.
    if (onBridge()) {
      zPosition();
    } else {
      position.z = 0;
    }
  }

  // Calculates and assigns the z-position corresponding with its current position.
  void zPosition() {
    position.z = road.zValues[ceil(position.x / road.precision)];
  }

  // Returns true if the vehicle is on the Bridge.
  boolean onBridge() {
    return position.x >= 0 && position.x <= road.size.x;
  }

  // Returns true of the vehicle overlaps with another vehicle on the road based on given position.
  boolean overlapsWithOtherVehicle(PVector nextPosition) {
    for (Vehicle other : road.vehicles) {
      // If it is itself.
      if (other == this) continue; 
      // NOTE: Continue ignores code after it and starts with next cycle.

      // Check whether this on nextPosition overlaps with the other vehicle.
      if (doOverlap(nextPosition, this, other)) {
        return true;
      }
    }
    return false;
  }

  // Return true if given position with the size of this vehicle overlaps with the other vehicle.
  boolean doOverlap(PVector nextPosition, Vehicle vehicleThis, Vehicle vehicleOther) {
    // Left top corner of this vehicle on given next position.
    PVector leftTopThis = new PVector(
      nextPosition.x - vehicleThis.size.x/2, 
      nextPosition.y - vehicleThis.size.y/2
      );
    // Right top corner of this vehicle on given next position.
    PVector rightBottomThis = new PVector(
      nextPosition.x + vehicleThis.size.x/2, 
      nextPosition.y + vehicleThis.size.y/2
      );
    // Left top corner of the other vehicle.
    PVector leftTopOther = new PVector( 
      vehicleOther.position.x - vehicleOther.size.x/2, 
      vehicleOther.position.y - vehicleOther.size.y/2
      );
    // Right top corner of the other vehicle.
    PVector rightBottomOther = new PVector( 
      vehicleOther.position.x + vehicleOther.size.x/2, 
      vehicleOther.position.y + vehicleOther.size.y/2
      );

    // RB┃ ┏━━
    // ━━┛ ┃LT
    // ────────► x
    if (rightBottomOther.x < leftTopThis.x || rightBottomThis.x < leftTopOther.x) {
      return false;
    }

    // │ RB┃
    // │ ━━┛
    // │┏━━
    // │┃LT
    // ▼ y
    if (rightBottomOther.y < leftTopThis.y || rightBottomThis.y < leftTopOther.y) {
      return false;
    }

    return true;
  }
}
