ArrayList<Agent> agents;
int totalNum = 800;
int order = 0;
int index = 1;

void setup() {
  size(800, 800);
  colorMode(HSB, totalNum, 100, 100);
  initiateCore();
}

void draw() {
  background(0, 0, 0);
  if (index < totalNum) {
    if(random(1) > 0.5){
      agents.add(new Agent(new PVector(0, random(height)), index));
    }else{
      agents.add(new Agent(new PVector(width, random(height)), index));
    }
    index ++;
  }
  for (Agent a : agents) {
    PVector s = PVector.random2D().mult(4);
    a.update(s);
  }
  fill(0, 0, 100);
  text(index, 20, 20);
}

void initiateCore() {
  agents = new ArrayList<Agent>();
  agents.add(new Agent(new PVector(width/2, height/2), 0));
}
