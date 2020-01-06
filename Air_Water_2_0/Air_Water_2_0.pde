//Air + Water 2. 0 
import processing.serial.*;

// Create object from Serial class.
Serial mySerial;

// Data received from the serial port.
String windSpeedString = "";
float windSpeed = 0.0;
// If the windSpeed is greater than this
// we consider the bubble as being blown.
final float blowingThreshold = 0.05;
// Keep track of if a bubble is being blown.
boolean blowingBubblePrevious = false;

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
final String port = "/dev/cu.usbmodem14101";

void setup() {
  size(800, 800);
  mySerial = new Serial(this, port, 9600);
}

void draw() {
  background(255);

  windSpeedString = mySerial.readStringUntil('\n');
  if (windSpeedString != null) {
    windSpeed = float(windSpeedString);
    println(windSpeed);
  }

  // True if the user is blowing right now.
  boolean blowingBubble = windSpeed > blowingThreshold;

  // Transition from not blowing to blowing.
  boolean startedBlowing = !blowingBubblePrevious && blowingBubble;
  if (startedBlowing) {
    bubbles.add(new Bubble());
  }

  // Get a handle to the last bubble.
  Bubble lastBubble = bubbles.size() > 0 ? bubbles.get(bubbles.size() -1) : null;

  // Transition from blowing to not blowing.
  boolean stoppedBlowing = blowingBubblePrevious && !blowingBubble;
  if (stoppedBlowing) {
    if (lastBubble != null) {
      lastBubble.release();
    }
  }

  // If we're blowing a bubble.
  if (blowingBubble) {
    if (lastBubble != null) {
      lastBubble.grow(windSpeed);
    }
  }

  // Save as previous.
  blowingBubblePrevious = blowingBubble;

  for (int i = bubbles.size()-1; i >=0; i--) {
    Bubble bubble = bubbles.get(i);
    // Update and draw the bubble.
    bubble.update();
    bubble.draw();
    // A Bubbles death.
    if (bubble.isDead) {
      bubbles.remove(i);
    }
  }
}
