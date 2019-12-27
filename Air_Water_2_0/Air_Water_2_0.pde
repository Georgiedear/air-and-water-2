ArrayList<Bubble> bubbles;

void setup() {
  size(800, 800);
  bubbles = new ArrayList<Bubble>();
}

void draw() {
  background(255);

  //For the Input from the bubble wand
  //For now lets do a key press to display the growth of a bubble
  if (keyPressed == true) {
    Bubble lastBubble = bubbles.get(bubbles.size() -1);
    lastBubble.grow();
  }

  for (Bubble bubble : bubbles) {
    bubble.move();
    bubble.draw();
  }
}

void keyReleased() {
  bubbles.add(new Bubble());
}
