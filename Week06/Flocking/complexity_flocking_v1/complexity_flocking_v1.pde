//使用以下变量值能够获得稳定的图形模式
//maxspeed = 3.00;
//maxforce = 1.45;
//seperateIndex = 5.00;
//AlignIndex = 3.60;
//CohensionIndex = 2.83;

import controlP5.*;
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.processing.*;

ToxiclibsSupport gfx;
Voronoi voronoi;

ArrayList myBoid;

ControlP5 bar;
int canvasLeftCornerX = 10;
int canvasLeftCornerY = 100;
int barWidth = 150;

float maxspeed = 3.0;
float maxforce = 0.05;
float separateIndex = 1.5;
float alignIndex = 1.0;
float cohesionIndex = 1.0;
int boidNum = 100;
int oldBoidNum;//this value is used to check if boidNum value to be changed.

boolean controlPanelBack = true;
String[] name = {":: Complexity  上海交通大学设计管理研究所 | 媒体与设计学院 :: 2012 :: 张立群"};//title string

void setup() {
  size(1200, 600);

  gfx = new ToxiclibsSupport(this);

  bar = new ControlP5(this);
  bar.addSlider("maxspeed", 0, 10, 3.0, canvasLeftCornerX, canvasLeftCornerY, barWidth, 20);
  bar.addSlider("maxforce", 0, 2, 0.05, canvasLeftCornerX, canvasLeftCornerY+30, barWidth, 20);
  bar.addSlider("separateIndex", 0, 5, 1.5, canvasLeftCornerX, canvasLeftCornerY+60, barWidth, 20);
  bar.addSlider("alignIndex", 0, 5, 1.0, canvasLeftCornerX, canvasLeftCornerY+90, barWidth, 20);
  bar.addSlider("cohesionIndex", 0, 5, 1.0, canvasLeftCornerX, canvasLeftCornerY+120, barWidth, 20);
  bar.addSlider("boidNum", 0, 1000, 100, canvasLeftCornerX, canvasLeftCornerY+150, barWidth, 20);
  bar.setAutoDraw(false);
  
  frame.setTitle(name[0]);//title string

  reset();

  smooth();
}

//re-draw boids with new boidNum value if the boidNum value to be changed.
void reset() {
  //reflash screen, but will cause the screen blink when drag the bar quickly and feel not camfortable.
  //fill(0, 0, 150);
  //rect(0, 0, width, height);

  // Add an initial set of boids into the system  
  myBoid = new ArrayList();

  float ballRnoise = 0;
  for (int i = 0; i < boidNum; i++) {
    color cb = color(0, 200, random(255));
    float ballR = noise(ballRnoise)*10;
    Boid mboid = new Boid(new PVector(random(width), random(height)), ballR, cb, maxspeed, maxforce, separateIndex, alignIndex, cohesionIndex);
    myBoid.add(mboid);
    ballRnoise += 0.01;
  }

  oldBoidNum = boidNum;//assign new boidNum value to oldBoidNum.
}

//check if boidNum has been changed, if changed, then re-draw boids with new boidNum value.
void checkBoidNum() {
  if (boidNum != oldBoidNum) {
    reset();
  }
}

void draw() {
  //background(0);
  fill(0, 0, 150, 5);
  rect(0, 0, width, height);
  //drawVoronoi();
  for (int i = 0; i < myBoid.size(); i++) {
    Boid mb = (Boid)myBoid.get(i);
    mb.run(myBoid);
  }

  if (controlPanelBack) {
    fill(160, 255);
  }
  else if (!controlPanelBack) {
    noFill();
  }
  noStroke();
  rect(canvasLeftCornerX-10, canvasLeftCornerY-10, 240, 190);

  //drawVoronoi();
  checkBoidNum();
  bar.draw();
  //saveFrame("imageSerial/flockingVoronoi-######.png");//output image serial for movie making.
}

void drawVoronoi(){
  voronoi = new Voronoi();//voronoi data update at the beginning of each frame
  
  for (int i=0;i<myBoid.size();i++) {
    Boid mb = (Boid)myBoid.get(i);
    Vec2D voroPoint = new Vec2D(mb.loc.x, mb.loc.y);
    voronoi.addPoint(voroPoint);
  }
  
  noFill();
  stroke(255);
  strokeWeight(1);
  
  for (Polygon2D polygon : voronoi.getRegions()) {
    gfx.polygon2D(polygon);
    //gfx.polygon2D(polygon.smooth(0.1, 0.001));
  }
  
  //draw point
  for (Vec2D v : voronoi.getSites()) {
    strokeWeight(4);
    //point(v.x, v.y);
  }  
}

// Add a new boid into the System
void mousePressed() {
  color cb = color(255, 255, 0);
  Boid mboid = new Boid(new PVector(mouseX, mouseY), 5, cb, maxspeed, maxforce, separateIndex, alignIndex, cohesionIndex);
    myBoid.add(mboid);
}

void keyPressed() {
  if (key ==  'h') {
    if (controlPanelBack) {
      controlPanelBack = false;
    }
    else if (!controlPanelBack) {
      controlPanelBack = true;
    }
  }

  if (key == ' ') {
    exit();
  }
}
