void setupGUI() {
  control.setAutoDraw(false);

  /* ControlP5 Documentation:
   *  - Button: http://www.sojamo.de/libraries/controlP5/examples/controllers/ControlP5button/ControlP5button.pde
   *  - Slider: http://www.sojamo.de/libraries/controlP5/examples/controllers/ControlP5slider/ControlP5slider.pde
   *  - Toggle: http://www.sojamo.de/libraries/controlP5/examples/controllers/ControlP5toggle/ControlP5toggle.pde
   */


  /*
   * Left Pedestrian Road
   *  - Buttons and Sliders
   */
  int x = 20;
  control.addButton("addLP")
    .setValue(0)              // Start Value
    .setPosition(x, 30)       // Draw Position     
    .setSize(20, 20)          // Draw Size
    .setCaptionLabel("+");    // Caption Label (Text)
  control.addButton("remLP")
    .setValue(0)
    .setPosition(x + 30, 30)
    .setSize(20, 20)
    .setCaptionLabel("-");
  control.addSlider("a1LP")
    .setValue(110)
    .setRange(50, 150)        // Range of the Slider
    .setPosition(x, 60)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)  // Tick Marks (50 - 70 - 90 - etc...)
    .setCaptionLabel("Height (1)");
  control.addSlider("b1LP")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 90)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Width (1)");
  control.addSlider("a2LP")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 120)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Height (2)");
  control.addSlider("b2LP")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 150)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Width (2)");

  /*
   * Right Pedestrian Road
   *  - Buttons and Sliders
   */
  x = 180;
  control.addButton("addRP")
    .setValue(0)
    .setPosition(x, 30)
    .setSize(20, 20)
    .setCaptionLabel("+");
  control.addButton("remRP")
    .setValue(0)
    .setPosition(x + 30, 30)
    .setSize(20, 20)
    .setCaptionLabel("-");
  control.addSlider("a1RP")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 60)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Height (1)");
  control.addSlider("b1RP")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 90)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Width (1)");
  control.addSlider("a2RP")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 120)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Height (2)");
  control.addSlider("b2RP")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 150)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Width (2)");

  /*
   * Left Bike Road
   * - Buttons
   */
  x = 360;
  control.addButton("addLB")
    .setValue(0)
    .setPosition(x, 30)
    .setSize(20, 20)
    .setCaptionLabel("+");
  control.addButton("remLB")
    .setValue(0)
    .setPosition(x, 60)
    .setSize(20, 20)
    .setCaptionLabel("-");

  /*
   * Right Bike Road
   * - Buttons
   */
  control.addButton("addRB")
    .setValue(0)
    .setPosition(x, 120)
    .setSize(20, 20)
    .setCaptionLabel("+");
  control.addButton("remRB")
    .setValue(0)
    .setPosition(x, 150)
    .setSize(20, 20)
    .setCaptionLabel("-");

  /*
   * Left Car Road
   * - Buttons, Sliders and Toggle
   */
  x = 510;
  control.addButton("addLC")
    .setValue(0)
    .setPosition(x, 30)
    .setSize(20, 20)
    .setCaptionLabel("+");
  control.addButton("remLC")
    .setValue(0)
    .setPosition(x + 30, 30)
    .setSize(20, 20)
    .setCaptionLabel("-");
  control.addSlider("aLC")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 60)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Height");
  control.addSlider("bLC")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 90)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Width");
  control.addSlider("sLC")
    .setValue(4)
    .setRange(1, 10)
    .setPosition(x, 120)
    .setSize(50, 20)
    .setNumberOfTickMarks(10)
    .setCaptionLabel("Frame");
  control.addToggle("sinLC")
    .setPosition(x, 150)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setCaptionLabel("Extra Curve");

  /*
   * Right Car Road
   * - Buttons, Sliders and Toggle
   */
  x = 620;
  control.addButton("addRC")
    .setValue(0)
    .setPosition(x, 30)
    .setSize(20, 20)
    .setCaptionLabel("+");
  control.addButton("remRC")
    .setValue(0)
    .setPosition(x + 30, 30)
    .setSize(20, 20)
    .setCaptionLabel("-");
  control.addSlider("aRC")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 60)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Height");
  control.addSlider("bRC")
    .setValue(110)
    .setRange(50, 150)
    .setPosition(x, 90)
    .setSize(50, 20)
    .setNumberOfTickMarks(6)
    .setCaptionLabel("Width");
  control.addSlider("sRC")
    .setValue(4)
    .setRange(1, 10)
    .setPosition(x, 120)
    .setSize(50, 20)
    .setNumberOfTickMarks(10)
    .setCaptionLabel("Frame");
  control.addToggle("sinRC")
    .setPosition(x, 150)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setCaptionLabel("Extra Curve");

  /*
   * Red/Green Light
   */
  control.addButton("toggleLight")
    .setValue(0)
    .setPosition(750, 15)
    .setSize(50, 50)
    .setCaptionLabel("toggle");

  /*
   * Party Mode
   */
  control.addButton("changePartyMode")
    .setValue(0)
    .setPosition(1250, 15)
    .setSize(50, 25)
    .setCaptionLabel("rainbow");
}

/*
 * Rendering GUI and Text
 */
void renderGUI() {
  cam.beginHUD();
  pushStyle();

  // Background Fill
  noStroke();
  fill(255, 120);
  rect(0, 0, width, 200);

  // Text
  fill(255);
  text("Left Pedestrian Roads", 20, 15);
  text("Amount: " + pedestrianLeft.amount, 20, 25);
  text("Right Pedestrian Roads", 180, 15);
  text("Amount: " + pedestrianRight.amount, 180, 25);
  fill(255, 120);
  rect(332, 0, 2, 200);
  fill(255);
  text("Left Bike Road", 360, 15);
  text("Amount: " + bikeLeft.amount, 360, 25);
  text("Right Bike Road", 360, 100);
  text("Amount: " + bikeRight.amount, 360, 110);
  fill(255, 120);
  rect(479, 0, 2, 200);
  fill(255);
  text("Left Car Road", 510, 15);
  text("Amount: " + carLeft.amount, 510, 25);
  text("Right Car Road", 620, 15);
  text("Amount: " + carRight.amount, 620, 25);

  // Red/Green Light
  if (!isRedLight) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  ellipse(775, 100, 50, 50);

  popStyle();
  control.draw();
  cam.endHUD();
}

/*
 * Handles all the Button Events:
 * Button calls this function when pressed.
 */
public void controlEvent(ControlEvent theEvent) {
  // Get the name of the button pressed from event:
  switch (theEvent.getController().getName()) {
    // Pedestrian Roads
  case "addLP":
    pedestrianLeft.addVehicle(); 
    break;
  case "remLP":
    pedestrianLeft.removeVehicle(); 
    break;
  case "addRP":
    pedestrianRight.addVehicle(); 
    break;
  case "remRP":
    pedestrianRight.removeVehicle(); 
    break;

    // Bike Roads
  case "addLB":
    bikeLeft.addVehicle(); 
    break;
  case "remLB":
    bikeLeft.removeVehicle(); 
    break;
  case "addRB":
    bikeRight.addVehicle(); 
    break;
  case "remRB":
    bikeRight.removeVehicle(); 
    break;

    // Car Roads
  case "addLC":
    carLeft.addVehicle(); 
    break;
  case "remLC":
    carLeft.removeVehicle(); 
    break;
  case "addRC":
    carRight.addVehicle(); 
    break;
  case "remRC":
    carRight.removeVehicle(); 
    break;

    // Red/Green Light
  case "toggleLight":
    isRedLight = !isRedLight;
    break;

    // Party Mode
  case "changePartyMode":
    partyMode = !partyMode;
    break;
  }
}

/*
 * Functions who catch the changed values of the sliders
 * Every slider has a function w/ the same name
 */
void a1LP(float value) {
  pedestrianLeft.amplitude1 = value;
}

void b1LP(float value) {
  pedestrianLeft.offset1 = 1 / value;
}

void a2LP(float value) {
  pedestrianLeft.amplitude2 = value;
}

void b2LP(float value) {
  pedestrianLeft.offset2 = 1 / value;
}

void a1RP(float value) {
  pedestrianRight.amplitude1 = value;
}

void b1RP(float value) {
  pedestrianRight.offset1 = 1 / value;
}

void a2RP(float value) {
  pedestrianRight.amplitude2 = value;
}

void b2RP(float value) {
  pedestrianRight.offset2 = 1 / value;
}

void aLC(float value) {
  carLeft.amplitude = value;
}

void bLC(float value) {
  carLeft.offset = 1 / value;
}

void sLC(float value) {
  carLeft.createColumns((int) value);
}

void sinLC(boolean flag) {
  carLeft.sin = flag;
}

void aRC(float value) {
  carRight.amplitude = value;
}

void bRC(float value) {
  carRight.offset = 1 / value;
}

void sRC(float value) {
  carRight.createColumns((int) value);
}

void sinRC(boolean flag) {
  carRight.sin = flag;
}

/*
 * Camera doesn't rotate if pressing/dragging mouse over controllers
 */
void limitMouse() {
  if (mouseX <= width && mouseY <= 200) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}

void mousePressed() {
  limitMouse();
}

void mouseDragged() {
  limitMouse();
}
