class Bubble {
  float x;
  float y;
  float r;
  float g;
  float speedX;
  float speedY;

  Bubble() {


    x = width/2-50;
    y = height/2-130;
    g = 0;

    speedX = random(-0.4, 0.4);
    speedY = random(-0.4, 0.4);
  }

  void grow () {
    noStroke();
    fill(0);
    ellipse(x, y, g++, g++);
  }

  void stay() {
    noStroke();

    fill(0);
    ellipse(x, y, g, g);
  }


  void move() {

    x = x+speedX;
    y = y+speedY;
  }




}
