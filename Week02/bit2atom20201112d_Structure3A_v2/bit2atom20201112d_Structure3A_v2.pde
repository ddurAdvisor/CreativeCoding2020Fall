/* 
   Structure 3 
   
   A surface filled with one hundred medium to small sized circles. 
   Each circle has a different size and direction, but moves at the same slow rate. 
   Display: 
   >>> A. The instantaneous intersections of the circles 
   B. The aggregate intersections of the circles 
 
   based on Implementation by Casey Reas <http://groupc.net>
*/ 
 
int numCircle = 100; 
Circle[] circles = new Circle[numCircle]; 
 
void setup(){ 
  size(800, 600); 
  frameRate(30); 
  for(int i=0; i<numCircle; i++) { 
    circles[i] = new Circle(random(width), (float)height/(float)numCircle * i, 
                            int(random(1, 6))*10, random(-1.0, 1.0), random(-1.0, 1.0), i); 
  } 
  ellipseMode(CENTER); 
  background(255); 
}

void draw(){ 
  background(255); 
  stroke(0, 10); 
  for(int i=0; i<numCircle; i++) { 
    circles[i].update(); 
  } 
  for(int i=0; i<numCircle; i++) { 
    circles[i].move(); 
  } 
  for(int i=0; i<numCircle; i++) { 
    circles[i].makepoint(); 
    circles[i].makeCircle();
  } 
  noFill(); 
}
