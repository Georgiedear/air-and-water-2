//Air + Water 2. 0 
import processing.serial.*;

// Create object from Serial class.
Serial mySerial;

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
ArrayList<WaterColor> waterColors = new ArrayList<WaterColor>();

final String port = "/dev/cu.usbmodem14201";

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

void setup() {
  size(800, 800);

  wands[0] = new Wand(width * 0.25, height * 0.5);
  wands[1] = new Wand(width * 0.5, height * 0.5);
  wands[2]= new Wand(width * 0.75, height * 0.5);

  bubbleImg =  loadImage("img/Bubble_Draft.png");

  for (int i = 0; i < images.length; i++) {
    String imagePath = images[i];
    waterColorImages[i] = loadImage(imagePath);
  }

  mySerial = new Serial(this, port, 9600);
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
  for (int i = 0; i < ws.length; i++) {
    float speed = float(ws[i]);
    Wand w = wands[i];
    w.update(speed);
  }
}

void draw() {
  background(255);
  
  updateWands();

  for (WaterColor w : waterColors) {
    w.draw();
  }

  // Loop through to update and draw.
  // We loop forward to draw so that new bubbles are in front.
  for (Bubble b : bubbles) {
    b.update();
    b.draw();
  }

  // Loop through backward to remove dead bubbles.
  for (int i = bubbles.size() - 1; i >= 0; i--) {
    Bubble bubble = bubbles.get(i);
    // A Bubbles death.
    if (bubble.isDead) {
      //waterColors.add(new WaterColor(bubble.x, bubble.y, bubble.g));
      bubbles.remove(i);
    }
  }
}
