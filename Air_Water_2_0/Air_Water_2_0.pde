//Air + Water 2. 0 
import processing.serial.*;
Serial mySerial;  // Create object from Serial class

String myString = null;
int nl = 10;
int myRecievedVal;      // Data received from the serial port


ArrayList<Bubble> bubbles;
int storedTime;
int totalTime;

void setup() {
  size(800, 800);
  bubbles = new ArrayList<Bubble>();
  storedTime = millis();
  totalTime = 5000;
  finished = false;

  String myPort = Serial.list()[4];
  //mySerial = new Serial(this, "/dev/cu.usbmodem1411", 9600); //1411

  mySerial = new Serial(this, myPort, 9600); //1411
}


void draw() {
  background(255);
  println(myRecievedVal);

  while ( mySerial.available() > 0) {  // If my data is available,
    //myRecievedVal = mySerial.read(); // read it and store it in myRecievedVal
    myString = mySerial.readStringUntil(nl);


    if (myString != null) {

      myRecievedVal = int(myString);
    }

    //For the Input from the bubble wand
    //For now lets do a key press to display the growth of a bubble
    if (myRecievedVal == 0 && bubbles.size() >= 1) {
      Bubble lastBubble = bubbles.get(bubbles.size() -1);
      lastBubble.grow();
      lastBubble.inital();
    } else {

      if (myRecievedVal == 1 && bubbles.size() <= 0  ) {

        bubbles.add(new Bubble());
        storedTime = millis();
      }
    }
    //Displays the bubbles
    for (Bubble bubble : bubbles) {
      bubble.move();
      bubble.display();
    }


    //Have one Bubble Appear at the start of the program

    ////A Bubbles death


    for (int i = bubbles.size()-1; i >=0; i--) {

      int passedTime = millis() - storedTime;
      int total = bubbles.size();
      if (passedTime > totalTime) {
        println("I'm dead" + total);
        storedTime = millis();
        bubbles.remove(i);
      }
    }



    //If there are no Bubbles left make the for loop go 
    //through the array forward not backwards.

    //BUBBLE SPRITE???? I MADE THIS BY ACCIDENT
    //for (int i = bubbles.size()-1; i >= 0; i--) {
    //  if(i < 1 ) {
    //  bubbles.add(new Bubble());
    //  }
    //}
  }

  //Add a new bubble after blowing one
  //void keyReleased() {
  //  bubbles.add(new Bubble());
  //  storedTime = millis();
  //}
}
