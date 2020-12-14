Tree tree = new Tree();
 
void setup() {
  size(1200,600);
  colorMode(RGB, 255);
  background(192);
  smooth();
}
 
void draw() {
}
 
void keyReleased() {
  background(192);
}
 
void mouseReleased() {
  tree = new Tree(mouseX, height, height-mouseY, 1);
  tree.render();
}
