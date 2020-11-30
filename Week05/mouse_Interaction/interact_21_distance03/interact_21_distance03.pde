float maxDistance;

void setup() {
  size(600, 400);
  background(0);
  stroke(255);
  maxDistance = dist(0, 0, width, height);
}

void draw() {
  background(0);
  for(int i = 0; i < width + 20; i+=20){
    for(int j = 0; j < height + 20; j+=20){
      float mouseDist = dist(mouseX, mouseY, i, j);
      float a = map(mouseDist, 0, maxDistance, 0, 360);
      float s = map(mouseDist, 0, maxDistance, 1, 20);
      pushMatrix();
      translate(i, j);
      strokeWeight(s);
      rotate(radians(a));
      line(-10, 0, 10, 0);
      popMatrix();
    }
  }
}
