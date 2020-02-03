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
    pushStyle();
    noStroke();
    imageMode(CENTER);
    tint(255, 210);
    image(bubbleImg, x, y, g, g);
    popStyle();
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
