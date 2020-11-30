String letters = "";

void setup() {
  size(600, 400);
  background(0);
  textSize(60);
  textAlign(CENTER);
  fill(255);
}

void draw() {
  background(0);
  text(letters, width/2, 75);
}

void keyPressed() {
  if (key == BACKSPACE) {
    if (letters.length() > 0) {
      letters = letters.substring(0, letters.length()-1);
    }
  } else {
    letters = letters + key;
  }
}
