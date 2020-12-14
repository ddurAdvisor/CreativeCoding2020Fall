void mouseClicked(){
  fadeScreen();
  newTrees();
  for(int i=0; i<nTrees; i++)
    trees[i].draw();
}
 
void keyTyped(){
  if(key=='=' || key=='+'){
    nTrees++;
    newTrees();
  }
  if(key=='-' || key=='_'){
    if(nTrees>1)
    {
      nTrees--;
      newTrees();
    }
  }
  if(key=='s'){
    addSnow = !addSnow;
  }
  if(key==' '){
    blankScreen();
  }
 
  if(key=='b'){
    addBlur = !addBlur;
  }
  
  if(key=='1')
    initializeTreeValues();
  if(key=='2'){
    branchWidthInit = 10;
    totalBranchLengthInit = 300;
    nBranchDivisionsInit = 30;
    percentBranchlessInit = .3;
    branchSizeFractionInit = .5;
    dThetaGrowMaxInit = PI/15;
    dThetaSplitMaxInit = PI/6; 
    oddsOfBranchingInit = .1;
  }
  
  
}

