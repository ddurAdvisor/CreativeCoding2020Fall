ArrayList<bird> population, saved;
ArrayList<pipe> pipes;
float TOTAL;
int Gens;
int counter;
int birdSurvive;
int maxSurvive;

PImage[] dover = new PImage[6];

boolean showBird = false;

void setup() {
  size(1600, 480);

  imageMode(CENTER);
  for (int i = 0; i < 6; i ++) {
    dover[i] = loadImage("dove0"+(i+1)+".png");
  }

  TOTAL = 500;
  pipes = new ArrayList<pipe>();
  population = new ArrayList<bird>();
  saved = new ArrayList<bird>();
  for (int i = 0; i < TOTAL; i++) {
    population.add(new bird());
  }
  counter = 0;
}

void draw() {
  background(51);
  if (counter % 75 == 0) {
    pipes.add(new pipe());
  }

  for (int i = pipes.size()-1; i >= 0; i--) {
    pipe p = pipes.get(i);
    p.update();
    if (p.offscreen()) {
      pipes.remove(i);
    }

    for (int j = population.size()-1; j >= 0; j--) {
      bird b = population.get(j);
      if (p.hit(b) || b.dead()) {
        saved.add(b);
        population.remove(j);
      }
    }
    birdSurvive = population.size();
  }

  if (population.size() == 0) {
    counter = 0;
    nextGeneration();
    pipes.clear();
    pipes.add(new pipe());
  }

  for (bird b : population) {
    b.show();
    b.update();
    b.think(pipes);
  }

  for (int i = pipes.size()-1; i >= 0; i--) {
    pipe p = pipes.get(i);
    p.show();
  }

  counter++;

  textSize(24);
  text("Generation: "+ Gens, 20, 35);
  text("BirdSurvive: " + birdSurvive + " (" + 100*birdSurvive/TOTAL+"%)", 20, 60);
  text("LifeSpan: " + counter, 20, 85);
  if (counter > maxSurvive) {
    maxSurvive = counter;
  }
  text("MaxSurvive: " + maxSurvive, 20, 110);

  if (counter > 500) {
    showBird = true;
  } else {
    showBird = false;
  }
}

void keyPressed() {
  if (key == 'b') {
    if (showBird) {
      showBird = false;
    } else {
      showBird = true;
    }
  }
}
