//Air + Water 

ArrayList<Bubble> bubbles;
int timer;
int last;
void setup() {
  size(800, 800);
  bubbles = new ArrayList<Bubble>();
}

void draw() {
  background(255);
  text(timer, 20, 20);
  timer = millis()-last;
  last = 0;
  //For the Input from the bubble wand
  //For now lets do a key press to display the growth of a bubble
  if (keyPressed == true && bubbles.size() >= 1) {
    Bubble lastBubble = bubbles.get(bubbles.size() -1);
    lastBubble.grow();
  }


  //Displays the bubbles
  //for (Bubble bubble : bubbles) {
  //  bubble.move();
  //  bubble.display();
  //}

  for (int i = bubbles.size()-1; i >= 0; i--) { 

    Bubble bubble = bubbles.get(i);
    bubble.display();
    bubble.move();
  }

//Bubbles death
  for (int i = bubbles.size() - 1; i >= 0; i--) {
 
  }
}

void keyReleased() {
  bubbles.add(new Bubble());
  if (millis() > last+10000) {
    last = millis();
    bubbles.remove(1);

    println("Im dead");
  }
}
