class RoadBike extends Road {

  // Other road where bikes can cross to.
  RoadBike other;
  // Roads between this road and other bike road.
  Road[] between;

  // The car road that the vehicles have influence on.
  RoadCar roadCar;

  // List of vehicles that have crossed and thus have to be remove and added to the other road.
  ArrayList<Vehicle> crossedBikesToRemove = new ArrayList();

  RoadBike(PVector position, RoadCar road) {
    super(position, new PVector(2 * width, 20, 0));
    this.roadCar = road;
  }

  // Assign a bike road to cross to. This has to be done at initialization!
  void initializeOtherRoadBike(RoadBike road) {
    this.other = road;
  }

  // Assign/replace all the road between this and the other road.
  void initializeRoadsBetween(Road[] roads) {
    this.between = roads;
  }

  void layoutRoad() {
    fill(200);
    rect(position.x, position.y, size.x, size.y);
  }

  void updateRoad() {
    // Influence of vehicles on columns.
    for (Column column : roadCar.columns) {
      for (Vehicle vehicle : vehicles) {
        // Is on bridge & euclidian distance from column to vehicle is less than the influence radius of the columns.
        if (vehicle.onBridge() && euclidianDistance(column.position, vehicle.position) < Column.influenceRadius) {
          column.influence.add(vehicle);
        }
      }
    }

    // Transfer crossed bikes, can not be done during for-loop.
    for (Vehicle v : crossedBikesToRemove) {
      // Reposition on other road.
      v.position.y = random(2.5, size.y - 2.5);
      v.position.x = size.x - v.position.x;
      v.road = other;

      // Add vehicle to other road.
      other.vehicles.add(v);
      other.amount++;
      
      // Remove vehicle from this road.
      vehicles.remove(v);
      amount--;
    }
    
    // Clear list.
    crossedBikesToRemove.clear();
  }
  
  void addVehicle() {
    vehicles.add(new Bike(this, new PVector(- random(size.x), random(2.5, size.y - 2.5), 0)));
    amount++;
  }
}
