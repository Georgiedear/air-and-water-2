//Air + Water 

ArrayList<Bubble> bubbles;
int storedTime;
int totalTime;

void setup() {
  size(800, 800);
  bubbles = new ArrayList<Bubble>();
  storedTime = millis();
  totalTime = 5000;
 
}

void draw() {
  background(255);
 
  //For the Input from the bubble wand
  //For now lets do a key press to display the growth of a bubble
  if (keyPressed == true && bubbles.size() >= 1) {
    Bubble lastBubble = bubbles.get(bubbles.size() -1);
    lastBubble.grow();
  }


  //Displays the bubbles
  for (Bubble bubble : bubbles) {
    bubble.move();
    bubble.display();
  }

  //for (int i = bubbles.size()-1; i >= 0; i--) { 

  //  Bubble bubble = bubbles.get(i);
  //  bubble.display();
  //  bubble.move();
  //}

  //Bubbles death
  
  int passedTime = millis() - storedTime;
  
  if (passedTime > totalTime) {
  println("I'm dead");
  storedTime = millis();
  bubbles.remove(1);
  }
  for (int i = bubbles.size()-1; i >= 0; i--) {
    
  }
}

void keyReleased() {
  bubbles.add(new Bubble());
}
