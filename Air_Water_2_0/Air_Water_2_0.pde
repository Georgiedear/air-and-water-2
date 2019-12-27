//import processing.serial.*;
//Serial myPort;  // Create object from Serial class
ArrayList<Bubble> bubbles;
boolean keyReleased;


void setup() {

  size(800, 800);

  bubbles = new ArrayList<Bubble>();
  bubbles.add(new Bubble());
  keyReleased = false;
}


void draw() {


  background(255); 

  //For the Input from the bubble wand
  //For now lets do a key press to display the growth of a bubble
  if (keyPressed == true) {
    for (int i = bubbles.size()-1; i >= 0; i--) { 

      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      Bubble bubble = bubbles.get(i);
      bubble.grow();
    }
  }
  else {
    //if not pressed, make the bubble stay and move.
    for (int i = bubbles.size()-1; i >= 0; i--) { 
      Bubble bubble = bubbles.get(i);
        bubble.stay();
      bubble.move();
    }
  }
  
  //create a new bubble

}

 
