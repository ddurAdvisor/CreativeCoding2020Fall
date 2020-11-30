float maxDistance;

void setup() {
  size(600, 400);
  rectMode(CENTER);
  background(0);
  stroke(255);
  noFill();
  maxDistance = dist(0, 0, width, height);
}

void draw() {
  background(0);
  for(int i = 0; i < width + 20; i+=20){
    for(int j = 0; j < height + 20; j+=20){
      float mouseDist = dist(mouseX, mouseY, i, j);
      float d = (mouseDist / maxDistance) * 100;
      rect(i, j, d, d);
    }
  }
}
