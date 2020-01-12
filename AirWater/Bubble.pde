class Bubble {
  float x;
  float y;
  float r;
  float g;
  float speedX;
  float speedY;
  color c;
  int releasedTime = -1;  
  boolean isDead = false;
  int lifeTime = 5000;

  Bubble(float x, float y) {
    this.x = x;
    this.y = y;
    g = 0;

    speedX = random(-0.4, 0.4);
    speedY = random(-0.4, 0.4);

    c = color(random(255), random(255), random(255));
  }

  void grow (float windSpeed) {
    g += windSpeed*2;
  }

  void draw() {
    noStroke();
    fill(c, 50);
    ellipse(x, y, g, g);
    tint(255, 255);
  }

  void release() {
    releasedTime = millis();
  }

  void dead() {
    isDead = true;
  }

  void update() {
    move();

    boolean isReleased = releasedTime != -1;
    if (isReleased && !isDead) {
      int timeSinceRelease = millis() - releasedTime;
      if (timeSinceRelease > lifeTime) {
        dead();
      }
    }
  }

  void move() {
    x = x+speedX;
    y = y+speedY;
  }
}
