class RoadBike extends Road {
  
  RoadBike(PVector position) {
    super(position, new PVector(2 * width, 20, 0));
  }
  
  // Layout of the Bike Road
  void layoutRoad() {
    fill(200);
    rect(position.x, position.y, size.x, size.y);
  }
  
  // Adds a Vehicle
  void addVehicle() {
    vehicles.add(new Bike(this, new PVector(- random(size.x), random(Bike.vehicleY, size.y - Bike.vehicleY), 0)));
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