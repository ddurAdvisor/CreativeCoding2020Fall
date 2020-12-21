PFont font;

Population population;
Button button;

void setup() {
  size(1600,720);
  colorMode(RGB,1.0);
  font = createFont("微软雅黑",24);
  int popmax = 10;
  float mutationRate = 0.05;  // A pretty high mutation rate here, our population is rather small we need to enforce variety
  // Create a population with a target phrase, mutation rate, and population max
  population = new Population(mutationRate,popmax);
  // A simple button class
  button = new Button(width/2-80,height-100,160,20, "重新生成新版配色");
}

void draw() {
  background(1.0);
  // Display the pallettes
  population.display();
  population.rollover(mouseX,mouseY);
  // Display some text
  textAlign(CENTER);
  fill(0);
  text("Generation #:" + population.getGenerations(),width/2,height-60);

  // Display the button
  button.display();
  button.rollover(mouseX,mouseY);
  //saveFrame("output/####.png");
}

// If the button is clicked, evolve next generation
void mousePressed() {
  if (button.clicked(mouseX,mouseY)) {
    population.selection();
    population.reproduction();
  }
}

void mouseReleased() {
  button.released();
}
