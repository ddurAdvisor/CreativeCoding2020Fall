int generations = 11;
int n = 1;
int slots = floor(pow(2, generations+1))-1;
int nextSlot = 1;
Branch[] branches = new Branch[slots];

void setup() {
  size(700, 500);
  smooth();
  noStroke();
  background(#EEEEFF);
  color c1 = color(#CCCCFF);
  color c2 = color(#EEEEFF);
  gradientBackground(c1, c2);
  branches[0] = new Branch(0, round(random(1, 3)), new Position((width+0.0)/2, height+0.0), PI/2);
}

void draw() {
  stroke(#332010);
  fill(0);
  for(int i=0; i<slots; i++) {
    while(branches[i] != null && branches[i].steps > 0) {
      branches[i].drawStep();
    }
    if(nextSlot <= slots - 2) {
      branches[nextSlot] = branches[i].generateChild(0);
      nextSlot += 1;
      branches[nextSlot] = branches[i].generateChild(1);
      nextSlot += 1;
    }
    branches[i].active = false;
  }
  noStroke();
  for(int i=0; i<slots; i++) {
    if(branches[i].generation == generations) {
      ellipseMode(CENTER);
      fill(#F2AFC1);
      ellipse(branches[i].position.x+1.5, branches[i].position.y, random(2, 10), random(2, 10));
      fill(#ED7A9E);
      ellipse(branches[i].position.x, branches[i].position.y+1.5, random(2, 10), random(2, 10));
      fill(#E54C7C);
      ellipse(branches[i].position.x-1.5, branches[i].position.y, random(2, 10), random(2, 10));
      float rnd = random(10);
      if(rnd < 0.1) {
        fill(#E54C7C);
        ellipse(branches[i].position.x+random(-100, 100), height-random(20), random(4, 10), random(4, 10));
      }
      else if(rnd > 9.9) {
        fill(#F2AFC1);
        ellipse(branches[i].position.x+random(-100, 100), height-random(20), random(4, 10), random(4, 10));
      }
    }
  }
  noLoop();
}

void mouseReleased() {
  color c1 = color(#CCCCFF);
  color c2 = color(#EEEEFF);
  gradientBackground(c1, c2);
  for(int i=0; i<slots; i++) {
    branches[i]=null;
  }
  branches[0] = new Branch(0, round(random(1, 3)), new Position((width+0.0)/2, height+0.0), PI/2);
  nextSlot = 1;
  loop();
}

void gradientBackground(color c1, color c2) {
  for (int i=0; i<=width; i++){
    for (int j = 0; j<=height; j++){
      color c = color(
      (red(c1)+(j)*((red(c2)-red(c1))/height)),
      (green(c1)+(j)*((green(c2)-green(c1))/height)),
      (blue(c1)+(j)*((blue(c2)-blue(c1))/height)) 
        );
      set(i, j, c);
    }
  }
} 
