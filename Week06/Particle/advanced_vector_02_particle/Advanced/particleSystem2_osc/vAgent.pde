class vAgent{
  
 Vec3D         acc;
 Vec3D         vel;
 Vec3D         pos;
 Vec3D         vec;
 float        maxVel;
 float        maxForce;
 float        sepScale;
 float        aliScale;
 float        cohScale;
 float        rangeOfVision;

 float        wandertheta;
 float        wanderomega;
 
 float        attOffset = 200;
 float        ht = envSize*2;
 int          drawColor;
   
 String       agentType = "vAgent";
 
 Vec3D sumSep = new Vec3D(0,0,0);
 
 // constructor simple
 vAgent(
     Vec3D _pos, 
     Vec3D _vec, 
     float _maxVel,
     float _maxForce){
   
   acc = new Vec3D(0,0,0);
   vel = _vec.copy();//new Vec3D(random(-1,1),random(-1,1),random(-1,1));    
   pos = _pos.copy();
   vec = _vec.copy();
   maxVel = _maxVel;
   maxForce = _maxForce;
   
   sepScale = 7;
   aliScale = 0.7;
   cohScale = 1;
    
   rangeOfVision = 70; 

   drawColor = 255;
   
 }
 
 // constructor complete
  vAgent(
     Vec3D _pos, 
     Vec3D _vec, 
     float _maxVel,
     float _maxForce,
     Vec3D _vel,
     float _sepScale,
     float _aliScale,
     float _cohScale,
     float _rangeOfVision){
   
   acc = new Vec3D(0,0,0);
   vel = _vel.copy();    
   pos = _pos.copy();
   vec = _vec.copy();
   maxVel = _maxVel;
   maxForce = _maxForce;
   
   sepScale = _sepScale;
   aliScale = _aliScale;
   cohScale = _cohScale;
    
   rangeOfVision = _rangeOfVision; 
   drawColor = 255;
 }
 
 
 void selfWander(){
   wander();
   
   vel.addSelf(acc);
   vel.limit(maxVel);
   pos.addSelf(vel);
   acc = new Vec3D(0,0,0);
   
   bounce(envSize);
   stroke(0,255,0);
   render();
 }
 
  void selfWander2D(){
   wander2D();
   
   vel.addSelf(acc);
   vel.limit(maxVel);
   pos.addSelf(vel);
   acc = new Vec3D(0,0,0);
   
   borders(envSize);
   stroke(255,0,0);
   render();
 }
 
 // calculates new location
 void step(vWorld world){ 
    updatePop(world.population);
    
    vel.addSelf(acc);
    vel.limit(maxVel);  
    pos.addSelf(vel);
    acc = new Vec3D(0,0,0);  // reset acc to 0 each iteration
    
    borders(envSize);
    render();
 }
 
 
 void updatePop(ArrayList pop){  
    
    // call population functions
    Vec3D sep = separate(pop);   
    Vec3D ali = align(pop);      
    Vec3D coh = cohesion(pop);   
    
    // weight vector
    sep.scaleSelf(sepScale);
    ali.scaleSelf(aliScale);
    coh.scaleSelf(cohScale);
    
    // add the vectors to acceleration
    acc.addSelf(sep);
    acc.addSelf(ali);
    acc.addSelf(coh);
  }    
 
 

 // steer
 Vec3D steer(Vec3D target, float threshold) {
    target.subSelf(pos); 
    float dist = target.magnitude();

    if (dist > 0 && dist < threshold) {
      target.normalize();
      target.scaleSelf(maxVel);
      target.subSelf(vel); 
      target.limit(maxForce); 
    } 
    else {
      target = new Vec3D(0,0,0);
    }
    return target;
  }


  // seek
  void seek(Vec3D target, float threshold) {
    acc.addSelf(steer(target, threshold));
  }
   
   
  // flee  
  void flee(Vec3D target, float threshold){
    acc.subSelf(steer(target, threshold));
  }   
  
  
  // wander
  void wander() {
    float wanderR =8;         
    float wanderD = 60;         
    float change = 0.1;
    wandertheta += random(-change,change);
    wanderomega += random(-change,change);

    Vec3D circleloc = vel.copy(); 
    circleloc.normalize();            
    circleloc.scaleSelf(wanderD);          
    circleloc.addSelf(pos);              

    //Vec3D circleOffSet = new Vec3D(wanderR*cos(wandertheta),wanderR*sin(wandertheta),0);
    Vec3D circleOffSet = new Vec3D(wanderR*sin(wandertheta)*cos(wanderomega),wanderR*sin(wandertheta)*sin(wanderomega),wanderR*cos(wandertheta));
    circleOffSet.addSelf(circleloc);
    acc.addSelf(steer(circleOffSet,ht)); 
  }
  
  void wander2D(){
    float wanderR =8;         
    float wanderD = 60;         
    float change = 0.1;
    wandertheta += random(-change,change);
    //wanderomega += random(-change,change);

    Vec3D circleloc = vel.copy(); 
    circleloc.normalize();            
    circleloc.scaleSelf(wanderD);          
    circleloc.addSelf(pos);              

    Vec3D circleOffSet = new Vec3D(wanderR*cos(wandertheta),wanderR*sin(wandertheta),0);
    //Vec3D circleOffSet = new Vec3D(wanderR*sin(wandertheta)*cos(wanderomega),wanderR*sin(wandertheta)*sin(wanderomega),wanderR*cos(wandertheta));
    circleOffSet.addSelf(circleloc);
    acc.addSelf(steer(circleOffSet,ht)); 
  }


// separation
  Vec3D separate (ArrayList pop) {
    Vec3D sum = new Vec3D(0,0,0);
    int count = 0;

    for (int i = 0 ; i < pop.size(); i++) {
      vAgent other = (vAgent) pop.get(i);
      float dist = pos.distanceTo(other.pos);
      
      if ((dist > 0) && (dist < rangeOfVision/1.5)) {
        Vec3D diff = pos.copy(); 
        diff.subSelf(other.pos);
        diff.normalize();
        diff.scaleSelf(1/dist);          
        sum.addSelf(diff);
        count++;                     
      }
    }
    if (count > 0) {
      sum.scaleSelf(1/(float)count);
    }
    sumSep = sum.copy();
    return sum;
  }
 
 
  // alignment
  Vec3D align (ArrayList pop) {
    Vec3D sum = new Vec3D(0,0,0);
    int count = 0;
    for (int i = 0 ; i < pop.size(); i++) {
      vAgent other = (vAgent) pop.get(i);
      float dist = pos.distanceTo(other.pos);
      if ((dist > 0) && (dist < rangeOfVision)) {
        sum.addSelf(other.vel);
        count++;
      }
    }
    if (count > 0) {
      sum.scaleSelf(1/(float)count);
      sum.limit(maxForce);
    }
    return sum;
  }


  // cohesion
  Vec3D cohesion (ArrayList pop) {
    Vec3D sum = new Vec3D(0,0,0);   
    int count = 0;
    for (int i = 0 ; i < pop.size(); i++) {
      vAgent other = (vAgent) pop.get(i);
      float dist = pos.distanceTo(other.pos);
      if ((dist > 0) && (dist < rangeOfVision)) {
        sum.addSelf(other.pos); 
        count++;
      }
    }
    if (count > 0) {
      sum.scaleSelf(1/(float)count);
      return steer(sum, ht);
    }
    return sum;
  }


  void render() {
    strokeWeight(3);
    
    Line3D l = new Line3D(pos,pos.add(vel.normalize().scale(20)));
    line(l.a.x,l.a.y,l.b.x,l.b.y);
    //stroke(255,0,0);
    //point(pos.x,pos.y,pos.z);
  }
  
  
  void borders(float envSize) {
    if (pos.x < 0) pos.x = width;
    if (pos.y < 0) pos.y = height;
    if (pos.x > width) pos.x = 0;
    if (pos.y > height) pos.y = 0;
  }
  
  void bounce(float envSize){
    if (pos.x < -envSize) vel.x = -vel.x;
    if (pos.y < -envSize) vel.y = -vel.y;
    if (pos.z < -envSize) vel.z = -vel.z;
    if (pos.x > envSize) vel.x = -vel.x;
    if (pos.y > envSize) vel.y = -vel.y;
    if (pos.z > envSize) vel.z = -vel.z;
    
    if (pos.x < -envSize) pos.x = -envSize;
    if (pos.y < -envSize) pos.y = -envSize;
    if (pos.z < -envSize) pos.z = -envSize;
    if (pos.x > envSize) pos.x = envSize;
    if (pos.y > envSize) pos.y = envSize;
    if (pos.z > envSize) pos.z = envSize;
  }

}
