class Button {
  float posX, posY;
  float buttonWidth, buttonHeight;
  color buttonColor;
  boolean pickColor;

  Button(float x, float y, float w, float h, color c) {
    posX = x;
    posY = y;
    buttonWidth = w;
    buttonHeight = h;
    buttonColor = c;
  }

  void showButton() {
    if (hover()) {
      stroke(255);
      strokeWeight(2);
    } else {
      noStroke();
    }
    if (mousePressed && hover()) {
      pickColor = true;
      fill(buttonColor, 100);
    } else {
      fill(buttonColor);
    }
    rect(posX, posY, buttonWidth, buttonHeight);
  }

  boolean hover() {
    if (mouseX < posX + buttonWidth && mouseX > posX &&
      mouseY < posY + buttonHeight && mouseY > posY) {
      return true;
    } else {
      return false;
    }
  }
}
