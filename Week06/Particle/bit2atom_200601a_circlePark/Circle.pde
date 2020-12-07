class Circle {
  PVector pos;
  float rr = initRadiu;
  boolean growing = true;
  boolean touch = false;

  Circle(PVector position) {
    pos = position;
  }

  void update() {
    circleTouch();
    growth();
    showCircle();
  }

  void showCircle() {
    noFill();
    stroke(0);
    strokeWeight(1);
    ellipse(pos.x, pos.y, rr*2, rr*2);
  }

  void growth() {
    if (edge() || touch) {
      growing = false;
    }
    if (growing) {
      rr ++;
    }
  }

  boolean edge() {
    return((pos.x+rr)>width || (pos.x-rr)<0 || (pos.y+rr)>height || (pos.y-rr)<0);
  }

  void circleTouch() {
    for (Circle cir : cirls) {
      float d = PVector.dist(cir.pos, pos);
      if (cir != this && d < cir.rr + rr) {
        touch = true;
      }
    }
  }
}
