class WaterColor {
  float x;
  float y;
  float g;
  PImage img;
  
  WaterColor(float x, float y, float g) {
    this.x = x;
    this.y = y;
    this.g = g;
    int rand = (int)random(waterColorImages.length);
    println(rand);
    img = waterColorImages[rand];
  }
  
  void draw() {
    //pushMatrix();
    //rotate(random(PI));
    blendMode(DARKEST);
    image(img, x, y, g, g);
    blendMode(BLEND);
    //popMatrix();
  }
  
  void update() {
  }
}
