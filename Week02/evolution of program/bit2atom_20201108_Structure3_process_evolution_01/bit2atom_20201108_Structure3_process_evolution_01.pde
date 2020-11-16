// Circle Intersection 
// by William Ngan <contact@metaphorical.net> 
 
// Modified by Casey Reas 
 
 
Circle circleA, circleB; 
 
void setup() 
{ 
  size( 300, 300 ); 
  frameRate( 30 ); 
 
  circleA = new Circle( 150, 150, 50 ); 
  circleB = new Circle( 150, 150, 60 ); 
 
  ellipseMode(CENTER); 
  rectMode(CENTER); 
  noStroke(); 
  smooth(); 
} 
 
 
void draw() 
{ 
  background(226); 
 
  fill( 153, 150 ); 
  ellipse( circleA.x, circleA.y, circleA.r*2, circleA.r*2 ); 
  ellipse( circleB.x, circleB.y, circleB.r*2, circleB.r*2 ); 
 
  circleB.x = mouseX; 
  circleB.y = mouseY; 
 
  intersect( circleA, circleB ); 
} 
 
 
class Circle 
{ 
  float x, y, r, r2; 
 
  Circle( float px, float py, float pr ) { 
    x = px; 
    y = py; 
    r = pr; 
    r2 = r*r; 
  } 
} 
 
 
void intersect( Circle cA, Circle cB ) { 
 
  float dx = cA.x - cB.x; 
  float dy = cA.y - cB.y; 
  float d2 = dx*dx + dy*dy; 
  float d = sqrt( d2 ); 
 
  if ( d>cA.r+cB.r || d<abs(cA.r-cB.r) ) return; // no solution 
  
  float a = (cA.r2 - cB.r2 + d2) / (2*d); 
  float h = sqrt( cA.r2 - a*a ); 
  float x2 = cA.x + a*(cB.x - cA.x)/d; 
  float y2 = cA.y + a*(cB.y - cA.y)/d; 
 
  noStroke(); 
  fill(0); 
  rect( x2, y2, 5, 5 ); 
 
  float paX = x2 + h*(cB.y - cA.y)/d; 
  float paY = y2 - h*(cB.x - cA.x)/d; 
  float pbX = x2 - h*(cB.y - cA.y)/d; 
  float pbY = y2 + h*(cB.x - cA.x)/d; 
 
  ellipse( paX, paY, 10, 10 ); 
  ellipse( pbX, pbY, 10, 10 ); 
 
} 
