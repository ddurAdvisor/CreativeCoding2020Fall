Particle[] particles = new Particle[20];

void setup(){
    size(800, 800);
    initiateParticleSystem();
}

void initiateParticleSystem(){
    for(int  i = 0; i < particles.length; i ++){
        float pxx = random(width/2-200, width/2+200);
        float pyy = random(height/2-200, height/2+200);
        PVector ploc = new PVector(pxx, pyy);
        particles[i] = new Particle(ploc, 15);
    }
}

void draw(){
    background(0);
    for(int  i = 0; i < particles.length; i ++){
        particles[i].run();
    }
}

void mousePressed(){
    initiateParticleSystem();
}