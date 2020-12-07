import toxi.processing.*;
import toxi.geom.*;

void setup(){
  size(400,400);
  
  Vec2D start = new Vec2D(50,80);
  Vec2D end = new Vec2D(150,200);
  
  // Vectors can create new vectors, applying  
  // a function to them and returning the  
  // result  
  Vec2D direction = end.sub(start);
  
  //or you can do like this
  //Vec2D direction = end.copy();
  //direction.subSelf(start);
  
  float vlength = direction.magnitude();
  // this gives the length of the vector  
  // which is the distance between the  
  // points  
  println(vlength);
  
  direction.normalize();
  float vlength2 = direction.magnitude();
  println(vlength2);
  
  direction.scaleSelf(100);
  float vlength3 = direction.magnitude();
  println(vlength3);
  
  
  strokeWeight(5);
  stroke(255);
  line(0,0,direction.x,direction.y);
}
