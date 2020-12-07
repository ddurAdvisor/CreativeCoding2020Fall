class PartiDot {
  PVector loc;
  PVector vel;
  PVector acc;

  float mass;
  float decay;
  float r;
  float rDest;
  color pcColor;
  
  boolean defaultRenderingMode = true;

  PartiDot(PVector initLoc, PVector initVel) {
    loc = initLoc;
    vel = initVel;
    acc = new PVector(0, 0);

    decay = random(0.9, 0.95);
    rDest = 5;
    r = 3;
    mass = sq(r)*0.0001+0.01;
  }

  void update(PImage pattern) {
    vel.add(acc);

    float maxVel = r+0.0025;
    float velLength = sq(vel.mag())+0.1;
    if (velLength>sq(maxVel)) {
      vel.normalize();
      vel.mult(maxVel);
    }

    loc.add(vel);
    vel.mult(decay);
    acc.set(0, 0, 0);

    if (loc.x>0 && loc.x<width-1 && loc.y>0 && loc.y<height-1) {
      int index = floor(loc.x) + floor(loc.y)*pattern.width;
      pcColor = color(pattern.pixels[index]);
      rDest = brightness(pattern.pixels[index])/float(255)*3+0.5;
    }
    else {
      rDest = 0.1;
    }

    r = lerp(r, rDest, 0.1);
    mass = sq(r)*0.0001+0.01;
  }

  void display() {
    if (defaultRenderingMode) {
      displayCircle();
    }

      if (key =='f') {
        defaultRenderingMode = false;
        displayRECT();
      }else if (key =='y') {
        defaultRenderingMode = false;
        displayEllipse();
      }else if (key =='p') {
        defaultRenderingMode = true;
      }
      else {
        defaultRenderingMode = true;
      }
  }

  void displayEllipse() {
    stroke(pcColor);
    strokeWeight(r*2);
    noFill();
    rectMode(CENTER);
    ellipse(loc.x, loc.y, r*3, r*3);
  }

  void displayRECT() {
    noStroke();
    fill(pcColor);
    rectMode(CENTER);
    rect(loc.x, loc.y, r*5, r*5);
  }

  void displayCircle() {
    stroke(pcColor);
    strokeWeight(r*8);
    point(loc.x, loc.y);
  }
}

