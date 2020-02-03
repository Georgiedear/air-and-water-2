class Wand {
  // Keep track of if a bubble is being blown.
  boolean blowingBubblePrevious = false;

  // If the windSpeed is greater than this
  // we consider the bubble as being blown.
  float blowingThreshold = 0.1;

  // The bubble being blown.
  Bubble bubble;

  float x;
  float y;
  float windSpeed;

  Wand(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update(float windSpeed) {
    this.windSpeed = windSpeed;

    // True if the user is blowing right now.
    boolean blowingBubble = windSpeed > blowingThreshold;

    // Transition from not blowing to blowing.
    boolean startedBlowing = !blowingBubblePrevious && blowingBubble;
    if (startedBlowing) {
      bubble = new Bubble(x, y);
      bubbles.add(bubble);
    }

    // Transition from blowing to not blowing.
    boolean stoppedBlowing = blowingBubblePrevious && !blowingBubble;
    if (stoppedBlowing) {
      if (bubble != null) {
        bubble.release();
      }
    }

    // If we're blowing a bubble.
    if (blowingBubble) {
      if (bubble != null) {
        bubble.grow(windSpeed);
      }
    }

    // Save as previous.
    blowingBubblePrevious = blowingBubble;
  }
}
