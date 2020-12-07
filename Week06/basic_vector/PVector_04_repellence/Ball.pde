class Ball {
  PVector location;
  float dd;
  int indexNum;
  boolean stable = true;

  Ball(PVector loc, float d, int index) {
    location = loc;
    dd = d;
    indexNum = index;
  }

  void show() {
    if (stable) {
      fill(255);
    } else {
      fill(#E80C0C);
    }
    noStroke();
    ellipse(location.x, location.y, dd, dd);
    fill(#5493E8);
    textAlign(CENTER, CENTER);
    text(indexNum, location.x, location.y);
  }

  void connection() {
    for (Ball other : theBall) {
      float ddd = PVector.dist(other.location, location);
      if (ddd > 0 && ddd < 50) {
        stroke(#5493E8);
        line(other.location.x, other.location.y, location.x, location.y);
      }
    }
  }

  void repellence() {
    for (Ball other : theBall) {
      float ddd = PVector.dist(other.location, location);
      if (ddd < (other.dd + dd)/2) {
        PVector repelForce = PVector.sub(location, other.location);
        if (repelForce.mag()>0) {
          stable = false;
        } else {
          stable = true;
        }
        repelForce.normalize();
        repelForce.mult(500/dd);
        location.add(repelForce);
        repelForce = new PVector(0, 0);
      }
    }
  }
}
