import peasy.*;
PeasyCam cam;

Boid [] flock = new Boid [200];

void setup(){
  size(800, 800, P3D);
  cam = new PeasyCam(this, 100);
  
  colorMode(HSB);
  for (int i = 0; i < flock.length; i++) {
    flock[i] = new Boid();
  }
  // this is a hack for 1.0.9
  //((PGraphics3D)g).cameraNear = -8;
}

void draw(){
  background(0);
  noStroke();
  lights();
  translate(width/2,height/2,0.0);
  for (int i = 0; i < flock.length; i++) {
    if (frameCount % 500 != 0) {
      flock[i].move(flock);
      flock[i].drawBoid();  
    }
    else {
      flock[i].reset();
    }
  }
}
