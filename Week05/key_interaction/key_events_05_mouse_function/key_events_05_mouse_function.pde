void setup() {
  size(600, 400);
  background(0);
  noStroke();
  fill(255, 50);
}

void draw() { 
//  Continuously draws
//  if(mousePressed){
//    ellipse(mouseX, mouseY, 200, 200);
//  }
}

void mousePressed() {
  // Draws once and resets when released
  ellipse(mouseX, mouseY, 200, 200);
}
