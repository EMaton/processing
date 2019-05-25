import peasy.*;
import controlP5.*;

int gem = 0;

PeasyCam cam;
ControlP5 control;

// All Roads (fixed amount)
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
  
  // Length of each road is 2 * width, - width to center
  carRight = new RoadCar(new PVector(- width, 0, 0));
  bikeRight = new RoadBike(new PVector(- width, 100, 0));
  pedestrianRight = new RoadPedestrian(new PVector(- width, 120, 0));
  
  // These will get rotated 180°
  carLeft = new RoadCar(new PVector(- width, 0, 0));
  bikeLeft = new RoadBike(new PVector(- width, 100, 0));
  pedestrianLeft = new RoadPedestrian(new PVector(- width, 120, 0));
  
  // Controls after initializing roads, otherwise 'NullPointer'
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
  textFont(BIG_FONT);
  textAlign(CENTER, CENTER);
  text("RIGHT", 0, 150, 0);
  
  // 'Left' Roads (rotated 180°)
  pushMatrix();
  rotateZ(PI);
  carLeft.render();
  carLeft.update();
  bikeLeft.render();
  bikeLeft.render();
  pedestrianLeft.render();
  pedestrianLeft.update();
  text("LEFT", 0, 150, 0);
  popMatrix();
  
  // GUI
  textFont(SML_FONT);
  textAlign(LEFT, BOTTOM);
  renderGUI();
}
