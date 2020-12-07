Particle[] particles;

int am = 1000;

void setup() {
  size(640, 640);
  noStroke();
  particles = new Particle[am];
  for (int i = 0; i < am; i++) {
    particles[i] = new Particle(new PVector(0, 0), i);
  }
}

void draw() {
  background(255);
  translate(width/2, height/2);
  for (int i = 0; i < am; i++) {
    particles[i].draw();
  }
  for (int i = 0; i < am; i++) {
    particles[i].drawMid();
    particles[i].move();
  }
}
