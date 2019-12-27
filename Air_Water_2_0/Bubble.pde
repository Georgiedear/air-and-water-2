class Bubble {
  float x;
  float y;
  float r;
  float g;
  float speedX;
  float speedY;
  color c;

  Bubble() {


    x = width/2-50;
    y = height/2-130;
    g = growth;

    speedX = random(-0.4, 0.4);
    speedY = random(-0.4, 0.4);

    c = color(random(255), random(255), random(255));
  }

  void grow () {
    noStroke();
    fill(c);
    ellipse(x, y, g++, g++);
  }

  void stay() {
    noStroke();

    fill(c);
    ellipse(x, y, g, g);
  }


  void move() {

    x = x+speedX;
    y = y+speedY;
  }
}
