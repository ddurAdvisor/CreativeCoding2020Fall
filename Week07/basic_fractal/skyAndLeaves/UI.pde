void mouseClicked(){
  generateBranches();
  windDirection = random(TWO_PI);
  
}

void keyTyped(){
  if(key == 'm')
    drawWind = !drawWind;
  if(key== 'n')
    drawVeins = !drawVeins;
  if(key=='c')
    blackLeaves = !blackLeaves;
    
  if(key == 'p'){
    pauseWind = !pauseWind;
    if(pauseWind)
      windVelocity = 0;
  }

  if(key == '='){
    if(transparency<240){
      transparency +=10;
      leafColor = color(5,113,3,transparency);
    }
    println("transparency: "+transparency);
  }
  if(key == '-'){
    if(transparency>0){
      transparency -=10;
      leafColor = color(5,113,3,transparency);
    }
    println("transparency: "+transparency);
  }
  
  //more/less wiggly
  if(key=='q'){
    if(maxdThetaWander==0)
      maxdThetaWander = .01;
    maxdThetaWander = maxdThetaWander*1.2;
    generateBranches();
  }
  if(key=='a'){
    maxdThetaWander = maxdThetaWander/1.2;
    generateBranches();
  }
  
  //more/less branches
  if(key=='w'){
    if(branchSpawnOdds<1)
      branchSpawnOdds += .1;
    generateBranches();
  }
  if(key=='s'){
    if(branchSpawnOdds>0)
      branchSpawnOdds -= .1;
    generateBranches();    
  }

  
  //fatter/thinner branches
  if(key=='e'){
    maxBranchThickness = maxBranchThickness*1.2;
    maxBranchSizeForLeaves = maxBranchSizeForLeaves*1.2;
    minBranchThickness = minBranchThickness*1.2;
    generateBranches();
  }
  if(key=='d'){
    maxBranchThickness = maxBranchThickness/1.2;
    maxBranchSizeForLeaves = maxBranchSizeForLeaves/1.2;
    minBranchThickness = minBranchThickness/1.2;
    generateBranches();
  }

  //more/less leaves
  if(key=='r'){
    if(leafSpawnOdds<1)
      leafSpawnOdds += .1;
    generateBranches();
  }
  if(key=='f'){
    if(leafSpawnOdds>0)
      leafSpawnOdds -= .1;
    generateBranches();    
  }
  
  //bigger/smaller leaves
  if(key=='t'){
    minLength = minLength*1.2; //leaf length
    maxLength = maxLength*1.2; //leaf length
    generateBranches();
  }
  if(key=='g'){
    minLength = minLength/1.2; //leaf length
    maxLength = maxLength/1.2; //leaf length
    generateBranches();
  }
  
  if(key =='['){
    if(nLeafPoints > 6){
      nLeafPoints-=2;
      defineLeafOutline();
      defineVeins();
      println("nLeafPoints: "+nLeafPoints);
    }
  }
  if(key ==']'){
    nLeafPoints+=2;
    defineLeafOutline();
    defineVeins();
    println("nLeafPoints: "+nLeafPoints);
  }
  
  //reset
  if(key =='z'){
    totalBranchLength = 400;
    maxBranchThickness = 10;
    maxBranchSizeForLeaves = 4;
    minBranchThickness = 2; 
    minSpawnDistance = .2;
    branchSpawnOdds = .8; 
    mindThetaSplit = PI*.1;
    maxdThetaSplit = PI*.3;
    maxdThetaWander = PI/20;
    minLength = 10; //leaf length
    maxLength = 30; //leaf length
    minWidth = .4;  //leaf width as a factor of length
    maxWidth = .5;  //leaf width as a factor of length
    maxBranchSizeForLeaves = 4;
    leafSpawnOdds = .7;
    generateBranches();
  }

  //hand-picked tree types!
  if(key =='1'){
    totalBranchLength = 400;
    maxBranchThickness = 10;
    maxBranchSizeForLeaves = 4;
    minBranchThickness = 2; 
    minSpawnDistance = .2;
    branchSpawnOdds = .8; 
    mindThetaSplit = PI/2;
    maxdThetaSplit = PI/2;
    maxdThetaWander = 0;
    minLength = 10; //leaf length
    maxLength = 30; //leaf length
    minWidth = .4;  //leaf width as a factor of length
    maxWidth = .5;  //leaf width as a factor of length
    maxBranchSizeForLeaves = 4;
    leafSpawnOdds = .7;
    generateBranches();
  }
  if(key =='2'){
    totalBranchLength = 400;
    maxBranchThickness = 10;
    maxBranchSizeForLeaves = 4;
    minBranchThickness = 2; 
    minSpawnDistance = .2;
    branchSpawnOdds = .8; 
    mindThetaSplit = PI/3;
    maxdThetaSplit = PI/3;
    maxdThetaWander = 0;
    minLength = 10; //leaf length
    maxLength = 30; //leaf length
    minWidth = .4;  //leaf width as a factor of length
    maxWidth = .5;  //leaf width as a factor of length
    maxBranchSizeForLeaves = 4;
    leafSpawnOdds = .7;
    generateBranches();
  }
  if(key =='3'){
    totalBranchLength = 400;
    maxBranchThickness = 10;
    maxBranchSizeForLeaves = 4;
    minBranchThickness = 2; 
    minSpawnDistance = .2;
    branchSpawnOdds = .8; 
    mindThetaSplit = PI/4;
    maxdThetaSplit = PI/4;
    maxdThetaWander = 0;
    minLength = 10; //leaf length
    maxLength = 30; //leaf length
    minWidth = .4;  //leaf width as a factor of length
    maxWidth = .5;  //leaf width as a factor of length
    maxBranchSizeForLeaves = 4;
    leafSpawnOdds = .7;
    generateBranches();
  }
  if(key =='4'){
    totalBranchLength = 400;
    maxBranchThickness = 10;
    maxBranchSizeForLeaves = 4;
    minBranchThickness = 2; 
    minSpawnDistance = .1;
    branchSpawnOdds = .3; 
    mindThetaSplit = 0;
    maxdThetaSplit = PI/4;
    maxdThetaWander = PI/4;
    minLength = 10; //leaf length
    maxLength = 30; //leaf length
    minWidth = .4;  //leaf width as a factor of length
    maxWidth = .5;  //leaf width as a factor of length
    maxBranchSizeForLeaves = 4;
    leafSpawnOdds = .7;
    generateBranches();
  }
  
  if(key =='5'){
    totalBranchLength = 400;
    maxBranchThickness = 40;
    minBranchThickness = 2; 
    minSpawnDistance = .5;
    branchSpawnOdds = .3; 
    mindThetaSplit = 0;
    maxdThetaSplit = PI/2;
    maxdThetaWander = PI/4;
    minLength = 10; //leaf length
    maxLength = 30; //leaf length
    minWidth = .4;  //leaf width as a factor of length
    maxWidth = .5;  //leaf width as a factor of length
    maxBranchSizeForLeaves = 4;
    leafSpawnOdds = .4;
    generateBranches();
  }
  
  if(key =='6'){
    totalBranchLength = 400;
    maxBranchThickness = 5;
    minBranchThickness = 2; 
    minSpawnDistance = .1;
    branchSpawnOdds = .2; 
    mindThetaSplit = 0;
    maxdThetaSplit = .3;
    maxdThetaWander = PI/30;
    minLength = 30; //leaf length
    maxLength = 60; //leaf length
    minWidth = .1;  //leaf width as a factor of length
    maxWidth = .2;  //leaf width as a factor of length
    maxBranchSizeForLeaves = 4;
    leafSpawnOdds = .7;
    generateBranches();
  }
  
  if(key =='7'){
    totalBranchLength = 400;
    maxBranchThickness = 5;
    maxBranchSizeForLeaves = 1;
    minBranchThickness = .5; 
    minSpawnDistance = .7;
    branchSpawnOdds = 1; 
    mindThetaSplit = 0;
    maxdThetaSplit = PI/6;
    maxdThetaWander = PI/30;
    minLength = 30; //leaf length
    maxLength = 60; //leaf length
    minWidth = .3;  //leaf width as a factor of length
    maxWidth = .5;  //leaf width as a factor of length
    leafSpawnOdds = 1;
    generateBranches();
  }
  
}

