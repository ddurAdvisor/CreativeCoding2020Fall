/* 
 
   Structure 3 (work in progress) 
   
   A surface filled with one hundred medium to small sized circles. 
   Each circle has a different size and direction, but moves at the same slow rate. 
   Display: 
   A. The instantaneous intersections of the circles 
   B. The aggregate intersections of the circles 
 
   Implemented by Casey Reas <http://groupc.net> 
   Uses circle intersection code from William Ngan <http://metaphorical.net> 
   Processing v.68 <http://processing.org> 
 
*/ 
 
int numCircle = 100; 
Circle[] circles = new Circle[numCircle]; 
 
void setup() 
{ 
  size(640, 480); 
  frameRate(30); 
  for(int i=0; i<numCircle; i++) { 
    circles[i] = new Circle(random(width), random(height), random(2, 6)*10); 
  } 
  ellipseMode(CENTER); 
  background(255); 
} 
 
 
void draw() 
{ 
  stroke(0, 10); 
  for(int i=0; i<numCircle; i++) { 
    circles[i].update(); 
  } 
} 
 
 
class Circle { 
 
  float x, y, r; 
 
  Circle( float px, float py, float pr) { 
    x = px; 
    y = py; 
    r = pr; 
  } 
  
  void update() { 
    noFill(); 
    stroke(0); 
    ellipse(x, y, r, r); 
  } 
}
