//Air + Water 2. 0 
import processing.serial.*;

// Create object from Serial class.
Serial mySerial;

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();

final String port = "/dev/cu.usbmodem1421";

// Bubble image.
PImage bubbleImg; 

// Water color images.
String images[] = {
  "img/Air+Water[breeze_green].png", 
  "img/Air+Water[cherry_red].png", 
  "img/Air+Water[cloud].png", 
  "img/Air+Water[cool_blue].png", 
  "img/Air+Water[pink_hush].png", 
  "img/Air+Water[yellow_splash].png" 
};

PImage waterColorImages[] = new PImage[images.length];

Wand wands[] = new Wand[3];

boolean useSensors = false;

PFont font;

PGraphics pg;

void setup() {
  //size(800, 800);
  fullScreen();
  pg = createGraphics(width, height);

  frameRate(30);
  smooth();
  font = createFont("Arial", 48);

  wands[0] = new Wand(width * 0.25, height * 0.5);
  wands[1] = new Wand(width * 0.5, height * 0.5);
  wands[2]= new Wand(width * 0.75, height * 0.5);

  bubbleImg =  loadImage("img/Air+Water[bubble].png");

  for (int i = 0; i < images.length; i++) {
    String imagePath = images[i];
    waterColorImages[i] = loadImage(imagePath);
  }

  if (useSensors) {
    mySerial = new Serial(this, port, 9600);
  }
}

void updateWands() {
  if (mySerial.available() == 0) {
    return;
  }

  String data;
  String validData = null;
  while ((data = mySerial.readStringUntil('\n')) != null) {
    validData = data;
  }

  if (validData == null) {
    return;
  };

  String[] ws = split(validData, ':');

  // May happen on first frame.
  if (ws.length != 3) {
    return;
  }

  //print(ws[0] + ":" + ws[1] + ":" + ws[2] + "\n");
  for (int i = 0; i < wands.length; i++) {
    float speed = float(ws[i]);
    Wand w = wands[i];
    w.update(speed);
  }
}

void keyPressed() {
  if (key == 'j') {
    wands[0].update(1);
  }
  if (key == 'k') {
    wands[1].update(1);
  }
  if (key == 'l') {
    wands[2].update(1);
  }
}

void keyReleased() {
  if (key == 'j') {
    wands[0].update(0);
  }
  if (key == 'k') {
    wands[1].update(0);
  }
  if (key == 'l') {
    wands[2].update(0);
  }
}

void drawFrameRate() {
  textFont(font, 16);
  fill(150);
  text(str(int(frameRate)), 10, 10, 200.0, 100.0);
}

void fadeGraphics(PGraphics c, int fadeAmount) {
  c.loadPixels();

  // iterate over pixels
  for (int i =0; i<c.pixels.length; i++) {

    // get alpha value
    int alpha = (c.pixels[i] >> 24) & 0xFF ;

    // reduce alpha value
    alpha = max(0, alpha-fadeAmount);

    // assign color with new alpha-value
    c.pixels[i] = alpha<<24 | (c.pixels[i]) & 0xFFFFFF ;
  }

  c.updatePixels();
}

void draw() {
  background(255);

  if (useSensors) {
    updateWands();
  } else {
    for (int i = 0; i < wands.length; i++) {
      Wand w = wands[i];
      w.update(w.windSpeed);
    }
  }

  // Loop through to update.
  // We loop forward to draw so that new bubbles are in front.
  for (Bubble b : bubbles) {
    b.update();
  }

  // Loop through backward to remove dead bubbles.
  pg.beginDraw();
  if (frameCount % 6 == 0) {
    fadeGraphics(pg, 0);
  }
  for (int i = bubbles.size() - 1; i >= 0; i--) {
    Bubble bubble = bubbles.get(i);
    // A Bubbles death.
    if (bubble.isDead) {
      int rand = (int)random(waterColorImages.length);
      PImage img = waterColorImages[rand];
      pg.pushStyle();
      pg.imageMode(CENTER);
      pg.image(img, bubble.x, bubble.y, bubble.g, bubble.g);
      pg.popStyle();
      bubbles.remove(i);
    }
  }
  pg.endDraw();

  image(pg, 0, 0);

  for (Bubble b : bubbles) {
    b.draw();
  }

  drawFrameRate();
}
