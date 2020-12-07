class Particle {
    PVector loc;
    float rr;
    PVector acc = new PVector(0, 0);
    PVector vel = new PVector(0, 0);
    float minDist = 20;

    Particle(PVector loc_, float rr_) {
        loc = loc_;
        rr = rr_;
    }
    
    void run(){
        attraction();
        update();
        crossCanvas();
        show();
    }

    void show() {
        fill(255);
        noStroke();
        ellipse(loc.x, loc.y, rr, rr);
        stroke(255, 0, 255);
        line(loc.x, loc.y, loc.x + rr*2*cos(vel.heading()), loc.y + rr*2*sin(vel.heading()));
    }
    
    void attraction(){
        for (Particle p : particles) { //(int i = 0; i < particles.length; i ++){// (Particle p : particles) {
            PVector direction = PVector.sub(loc, p.loc);
            println(direction);
            float dist = direction.mag();
            
            if(dist < minDist*3){
                stroke(255, 255, 0);
                line(loc.x, loc.y, p.loc.x, p.loc.y);
            }
            
            if(dist > 0 && dist < minDist){
                direction.normalize();
                direction.mult(100/dist);
                acc.add(direction);
            }else if(dist >= minDist){
                direction.normalize();
                direction.mult(-1/dist);
                acc.add(direction);
            }
        }
    }

    void update() {
        vel.add(acc);
        vel.limit(3);
        loc.add(vel);
        acc = new PVector(0, 0);
    }
    
    void crossCanvas(){
        if(loc.x > width) loc.x = 0;
        if(loc.x < 0) loc.x = width;
        if(loc.y > height) loc.y = 0;
        if(loc.y < 0) loc.y = height;
    }
}