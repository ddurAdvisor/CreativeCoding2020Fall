class Particle {
  PVector loc, vel;
  float a, s, radius;

  Particle(PVector l, float i) {
    loc = l;
    a = i;
    s = random(200, 250);
  }

  void draw() {
    //Change the size of the particle in relation to its distance from the center.
    radius = map(dist(loc.x, loc.y, 0, 0), 0, 150, 30, 1);
    fill(0, 150, 255);
    ellipse(loc.x, loc.y, radius, radius);
    //rectMode(CENTER);
    //rect(loc.x, loc.y, radius, radius);
  }

  void drawMid() {
    fill(255);
    ellipse(loc.x, loc.y, radius-4, radius-4);
    //rectMode(CENTER);
    //rect(loc.x, loc.y, radius-4, radius-4);
  }

  void move() {
    float r = sin(radians(frameCount*(s/200)));
    vel = new PVector(sin(radians(a))*r, cos(radians(a))*r);
    vel.mult(1.2);
    loc.add(vel);
  }
}
