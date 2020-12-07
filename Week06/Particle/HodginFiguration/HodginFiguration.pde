import processing.svg.*;

//Global Variables

PImage img;
int maxAgents;
ArrayList agentList;

boolean saveSVG = false;

float rad;

//Initialize
void setup(){
  size(600,818);
  img = loadImage("portrait02.png");//("Laocoon2SmallSize.jpg"); //("LaocoonMask.png"); //("Laocoon.png");
  img.resize(width, height);
  
  maxAgents = 100000;
  agentList = new ArrayList();
  rad = 5;
}

//Update
void draw(){
  background(255);
  //image(img, 0, 0);
  
  if(agentList.size() < maxAgents){
    //Agent myAgent = new Agent(new PVector(random(0+rad, width-rad), random(0+rad, height-rad)), rad);
    Agent myAgent = new Agent(new PVector(random(width/2-30, width/2+30), random(height/2-30, height/2+30)), rad);
    agentList.add(myAgent);
  }
  
  if (saveSVG) {
    beginRecord(SVG, "output/circlePark.svg");
  }
  
  for(int i = 0; i < agentList.size(); i ++){
    Agent tempAgent = (Agent)agentList.get(i);
    tempAgent.run();
  }
  
  if (saveSVG) {
    endRecord();
    saveSVG = false;
  }
}

void keyPressed() {
  if (key == 's') {
    save("output/HodginCirclePark.png");
  }
  if(key == 'p'){
    saveSVG = true;
  }
}
