class RoadBike extends Road {
  
  // Roads between this road and other RoadBike
  Road[] between;
  // Other road where bikes cross to.
  RoadBike other;
  
  ArrayList<Vehicle> crossedBikesToRemove = new ArrayList();
  
  RoadBike(PVector position) {
    super(position, new PVector(2 * width, 20, 0));
  }
  
  void initializeOtherRoadBike(RoadBike road) {
    this.other = road;
  }
  
  void initializeRoadsBetween(Road[] roads) {
    this.between = roads;
  }
  
  // Layout of the Bike Road
  void layoutRoad() {
    fill(200);
    rect(position.x, position.y, size.x, size.y);
  }
  
  void updateRoad() {
    for (Vehicle v : crossedBikesToRemove) {
      // Reposition on other road.
      v.position.y = random(Bike.vehicleY, size.y - Bike.vehicleY);
      v.position.x = size.x - v.position.x;
      v.road = other;
      
      other.vehicles.add(v);
      other.amount++;
      
      vehicles.remove(v);
      amount--;
    }
    crossedBikesToRemove.clear();
  }
  
  // Adds a Vehicle
  void addVehicle() {
    vehicles.add(new Bike(this, new PVector(- random(size.x), random(Bike.vehicleY, size.y - Bike.vehicleY), 0)));
    amount++;
  }
}
