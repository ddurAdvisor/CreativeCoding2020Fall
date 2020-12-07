class PController {
  ArrayList partiDots;
  int initialRandMag = 5;

  PController() {
    partiDots = new ArrayList();
  }

  void addParticles(int amt, PVector mouseLoc, PVector mouseVel) {
    for (int i=0;i<amt;i++) {
      float randRadiansLoc = random(2*PI);
      PVector initLocOffset = new PVector(cos(randRadiansLoc)*5, sin(randRadiansLoc)*5);
      float randRadiansVel = random(2*PI);
      float randMagVel = random(1, 5);
      PVector initVelOffset = new PVector(cos(randRadiansLoc)*randMagVel, sin(randRadiansLoc)*randMagVel);

      PVector initLoc = PVector.add(initLocOffset, mouseLoc);
      PVector initVel = PVector.add(initVelOffset, mouseVel);

      PartiDot additionalParticle = new PartiDot(initLoc, initVel);
      partiDots.add(additionalParticle);
    }
  }

  void repulse() {
    for (int i=0;i<partiDots.size();i++) {
      PartiDot targetParticle1 = (PartiDot) partiDots.get(i);
      for (int j=i+1;j<partiDots.size();j++) {
        PartiDot targetParticle2 = (PartiDot) partiDots.get(j);
        PVector dir = PVector.sub(targetParticle1.loc, targetParticle2.loc);
        float thres = (targetParticle1.r+targetParticle2.r)*3.5;//it is used to define inbetween distance of two particles.
        if ( dir.x > -thres && dir.x < thres && dir.y > -thres && dir.y < thres ) {
          float magnitude = dir.mag();
          float distSqrd = pow(magnitude, 3);
          if (distSqrd>0) {
            float pushingForce = 1/distSqrd;
            dir.normalize();
            dir.mult(pushingForce);
            PVector accOffset1 = PVector.div(dir, targetParticle1.mass);
            PVector accOffset2 = PVector.div(dir, targetParticle2.mass);
            targetParticle1.acc.add(accOffset1);
            targetParticle2.acc.sub(accOffset2);
          }
        }
      }
    }
  }

  void update(PImage pattern) {
    for (int i=0;i<partiDots.size();i++) {
      PartiDot targetPartiDot = (PartiDot) partiDots.get(i);
      targetPartiDot.update(pattern);
    }
  }

  void display() {
    for (int i=0;i<partiDots.size();i++) {
      PartiDot targetParticle = (PartiDot) partiDots.get(i);
      targetParticle.display();
    }
  }
}
