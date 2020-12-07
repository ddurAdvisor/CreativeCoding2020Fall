/*
a simple method how to create
a continous and smooth pathway with almost direct usage of
the random() function and without Perlin noise.

Read the Particle class and the .update() method
to get the idea.
*/
 
float posStep = 0.4;
int   nParticles = 500;
Particle[] particles;
 
void setup() {
  size(700,700,P2D);
  frameRate(60);
  background(255);
  particles = new Particle[nParticles];
   
  for(int i=0; i<nParticles; i++) {
    particles[i] = new Particle();
  }
}
 
void draw() {
  fill(255,10);
  rect(0,0,width,height);
//  background(0);
  translate(width/2, height/2);
 
  for(int i=0; i<nParticles; i++) {
    particles[i].update();
    particles[i].show();
  }
}
 
/* Useless
void keyPressed() {
  PVector q = new PVector(random(width)-width/2,random(height)-height/2);
  for(int i=0; i<nParticles; i++) {
    particles[i].pos = new PVector(q.x, q.y);
    particles[i].angle  = random(TWO_PI);
    particles[i].dAngle = 0;
  }
}
*/
 
void mousePressed() {
  for(int i=0; i<nParticles; i++) {
    particles[i].pos = new PVector(mouseX-width/2, mouseY-height/2);
    particles[i].angle  = random(TWO_PI);
    particles[i].dAngle = 0;
  }
}
