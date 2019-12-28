class Bubble {
  float x;
  float y;
  float r;
  float g;
  float speedX;
  float speedY;
  color c;

  Bubble() {
    x = width/2;
    y = height/2;
    g = 0;

    speedX = random(-0.4, 0.4);
    speedY = random(-0.4, 0.4);

    c = color(random(255), random(255), random(255));
  }

  void grow () {
    g++;
  }

  void display() {
    noStroke();
    fill(c);
    ellipse(x, y, g, g);
  }

  void move() {
    x = x+speedX;
    y = y+speedY;
  }

}
