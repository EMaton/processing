import peasy.*;
import controlP5.*;

// boolean value that indicates if the trafic light is red or not.
boolean isRedLight = false;
// boolean value that indicates if the color mode is enabled or not.
boolean partyMode = true;

// the width of the bridge.
final float bridgeWidth = 1600;

PeasyCam cam;
ControlP5 control;

// All the roads crossing the bridge.
RoadCar carRight;
RoadCar carLeft;
RoadBike bikeRight;
RoadBike bikeLeft;
RoadPedestrian pedestrianRight;
RoadPedestrian pedestrianLeft;

// Font Sizes
PFont SML_FONT;
PFont BIG_FONT;

void setup() {
  size(1600, 900, P3D);
  smooth(8);

  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance( 500 );
  cam.setMaximumDistance( 2000 );

  SML_FONT = createFont("Lucida Sans", 12);
  BIG_FONT = createFont("Lucida Sans", 32);

  carRight = new RoadCar(new PVector(-bridgeWidth, 0, 0));
  bikeRight = new RoadBike(new PVector(-bridgeWidth, 100, 0), carRight);
  pedestrianRight = new RoadPedestrian(new PVector(-bridgeWidth, 120, 0), carRight);

  // The left side will get rotated 180° in draw().
  carLeft = new RoadCar(new PVector(-bridgeWidth, 0, 0));
  bikeLeft = new RoadBike(new PVector(-bridgeWidth, 100, 0), carLeft);
  pedestrianLeft = new RoadPedestrian(new PVector(-bridgeWidth, 120, 0), carLeft);

  // This bidirectional relation between the left- and right bike road can not be done in the constructors.
  bikeRight.initializeOtherRoadBike(bikeLeft);
  bikeLeft.initializeOtherRoadBike(bikeRight);
  // Array containing all the roads between the two bike roads.
  Road[] roads = new Road[]{carLeft, carRight};
  bikeRight.initializeRoadsBetween(roads);
  bikeLeft.initializeRoadsBetween(roads);

  // Controls after initializing roads, otherwise 'NullPointer' because the controllers access these variables.
  control = new ControlP5(this);
  setupGUI();
}

void draw() {
  background(0);

  // 'Right' Roads
  carRight.render();
  carRight.update();

  bikeRight.render();
  bikeRight.update();

  pedestrianRight.render();
  pedestrianRight.update();

  // 'Left' Roads (rotated 180°)
  pushMatrix();
  rotateZ(PI);

  carLeft.render();
  carLeft.update();

  bikeLeft.render();
  bikeLeft.update();

  pedestrianLeft.render();
  pedestrianLeft.update();

  popMatrix();

  // GUI
  textFont(BIG_FONT);
  textAlign(CENTER, CENTER);
  text("RIGHT", 0, 150, 0);
  pushMatrix();
  rotateZ(PI);
  text("LEFT", 0, 150, 0);
  popMatrix();

  textFont(SML_FONT);
  textAlign(LEFT, BOTTOM);
  renderGUI();
}
