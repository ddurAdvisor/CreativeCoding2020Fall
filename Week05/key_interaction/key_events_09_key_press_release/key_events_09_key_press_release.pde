boolean drawT = false;

void setup() {
  size(600, 400);
  background(0);
  noStroke();
  textSize(200);
  textAlign(CENTER);
  fill(255);
}

void draw() {
  background(0);
  if (drawT == true) {
    text("T", width/2, height/2 + 75);
  }
}

void keyPressed() {
  if (key == 'T' || key == 't') {
    drawT = true;
  }
}

void keyReleased() {
  drawT = false;
}
