//importing the external library to use 3d camera
import peasy.*;
//making an instance of the 3d camera class
PeasyCam cam;

//making an arraylist which will store all the line info (x1,y1,x2,y2) for exporting.
ArrayList allLines;
//making an instance for text file.
PrintWriter output;

void setup(){
  //don't forget to write P3D if you want to have 3D sketch
  size(500,500,P3D);
  stroke(255);
  
  //setting the 3D camera
  cam = new PeasyCam(this, 500);
}

void draw(){
  //initialize arraylist (you need to do this somewhere at least once for any arraylist)
  allLines = new ArrayList();
  background(0);
  
  //calling drawTree subroutine
  drawTree(0,300,0,new PVector(0,-80,0));
}


//here is the subroutine for drawing tree recursively.
//parameter x stands for the x position of starting point of the branch.
//parameter y stands for the y position of starting point of the branch.
//parameter z stands for the z position of starting point of the branch.
//parameter branch used for calculating the length and direction of the branch line.
void drawTree(float x, float y,float z, PVector branch){
  //activate the command only if the length of the branch is bigger than 10
  if(branch.mag()>10){
    //make a new PVector with input parameter x, y, z.
    PVector ps = new PVector(x,y,z);
    //make another PVector copied from the one you have just made.
    PVector pe = ps.get();
    //vector addition to the previous PVector with branch vector you have input.
    //this will move the PVector pe to the end point of the branch.
    pe.add(branch);
    //change the color of the branch line by the length of the branch
    stroke(map(branch.mag(),10,50,0,255),150,0,map(branch.mag(),10,80,120,255));
    //draw line between start point and end point which makes a branch 
    line(ps.x,ps.y,ps.z,pe.x,pe.y,pe.z);
    //adding line position inside the arraylist as Strings for exporting later.
    allLines.add(ps.x+","+ps.y+","+ps.z+","+pe.x+","+pe.y+","+pe.z);
    
    //set the rotation radius for the next branch.
    float rad = radians(mouseY);
    
    //copy the branch vector
    PVector br1 = branch.get();
    //scale down the branch's length. this will be used for next branch.
    //this is important since you have set the condition which depends on the length of the branch.
    br1.mult(0.75);
    //rotate the branch on xy plane using the custom made rotation function.
    br1 = ROT(br1,rad);
    //rotate the branch on xz plane using the custom made rotation function.
    br1 = zROT(br1,rad);
    //feed this newly made br1 branch vector to own subroutine drawTree() using 
    //the endpoint of the previous branch you had as the start point for the next branch.
    drawTree(pe.x,pe.y,pe.z,br1);
    br1 = zROT(br1,-rad*2);
    drawTree(pe.x,pe.y,pe.z,br1);
    
    PVector br2 = branch.get();
    br2.mult(0.75);
    br2 = ROT(br2,-rad);
    br2 = zROT(br2,rad);
    drawTree(pe.x,pe.y,pe.z,br2);
    br2 = zROT(br2,-rad*2);
    drawTree(pe.x,pe.y,pe.z,br2);
  }
}


void keyPressed(){
  //when you press any key, it will create a new text with specified name
  output = createWriter("positions.txt");
  
  for(int i = 0; i<allLines.size(); i++){
    //look for all the line info inside the positions.txt
    String position = (String)allLines.get(i);
    //write each line info into the newly created text
    output.println(position);
  }
  //save the text
  output.flush();
  output.close();
}

//custom ration function works on xy plane
PVector ROT(PVector p,float ang){
  PVector pr = new PVector(p.x*cos(ang)-p.y*sin(ang),p.x*sin(ang)+p.y*cos(ang),p.z);
  return pr;
}

//custom rotation function works on xz plane.
PVector zROT(PVector p,float ang){
  PVector pr = new PVector(p.z*sin(ang)+p.x*cos(ang),p.y,p.z*cos(ang)-p.x*sin(ang));
  return pr;
}
