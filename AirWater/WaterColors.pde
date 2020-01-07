class WaterColor {
  float x;
  float y;
  float g;
  
  WaterColor(float x, float y, float g) {
    this.x = x;
    this.y = y;
    this.g = g;
  }
  
  void draw() {
    blendMode(DARKEST);
    image(coolBlue, x, y, g, g);
    blendMode(BLEND);
  }
  
  void update() {
  }
}
