//Air + Water 

ArrayList<Bubble> bubbles;
int storedTime;
int totalTime;
boolean finished;

void setup() {
  size(800, 800);
  bubbles = new ArrayList<Bubble>();
  storedTime = millis();
  totalTime = 5000;
  finished = false;
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
  ////A Bubbles death

  int passedTime = millis() - storedTime;

  if (passedTime > totalTime) {
    println("I'm dead");
    storedTime = millis();
    //bubbles.remove(1);
  }


  //If there are no Bubbles left make the for loop go 
  //through the array forward not backwards.
  //for (int i = 0; i < bubbles.size(); i++) {
  //  if (bubbles.size() < 0 ) {
  //    Bubble bubblePop = bubbles.get(i); 
  //      //bubblePop.finished();
            
  //        int passedTime = millis() - storedTime;


  //    if (bubblePop.finished() && passedTime > totalTime ) {
  //      println("I'm dead");
  //      storedTime = millis();
  //      bubbles.remove(1);
  //    }
  //  }
  //}

  //BUBBLE SPRITE???? I MADE THIS BY ACCIDENT
  //for (int i = bubbles.size()-1; i >= 0; i--) {
  //  if(i < 1 ) {
  //  bubbles.add(new Bubble());
  //  }
  //}
}

//Add a new bubble after blowing one
void keyReleased() {
  bubbles.add(new Bubble());
}
