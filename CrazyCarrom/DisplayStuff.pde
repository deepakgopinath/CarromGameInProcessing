void  displayOpeningPage()
{
    fill(255,25, 0);
    textAlign(CENTER);
    textSize(38);
    text("CRazzYyY CArroM", width/2 , height/2 - 100);
    textSize(22);
    text("CrEAted bY", width/2, height/2 - 40);
    textSize(28);
    text("DeEpaK goPiNatH", width/2, height/2 + 15 );
    textSize(20);
    fill(255,255,0);
    text("Hit Space to Continue", width/2, height/2 + 190);
    textSize(16);
    textAlign(LEFT);
}

void displayHelpPage()
{
    fill(255, 25, 0);
    textAlign(CENTER);
    textSize(30);
    text("RuLeS aND cOnTRoLs", width/2, height/2 - 250);
    textSize(18);
    
    text("The objective of the game is to pocket the queen and all the black carrom men", width/2, height/2 - 190);
    text("The striker is set in motion by a sling shot, using the mouse. Hit spacebar to launch", width/2, height/2 - 150);
    text("Press 'G' to toggle the gravity mode. An invisible gravitational force in a random direction", width/2, height/2 - 110);
    text("will be activated", width/2, height/2 - 80);
    text("Press 'A' to toggle AI mode. The carrom men and the queen will begin to flock to the center", width/2, height/2 -40);
    //text("Note: This mode remains activated in Level 2", width/2, height/2 - 10);
   
    text("Press 'H' for help", width/2, height/2 + 30);
    text("Press 'M' for mute/unmute", width/2, height/2 + 60);
    text("Press 'J' for obstruction jiggle", width/2, height/2 + 90);
    text("Note: Level 2 implements constantly changing physics parameters ", width/2, height/2 + 120);
    text("for the carrom men and striker", width/2, height/2+150);
    
    
    fill(255,255,0);
    textSize(20);
    text("Hit Space to Continue", width/2, height/2 + 190);
    textAlign(LEFT);
    textSize(16);
}
void showStrengthMeter()
{
  stroke(255);
  strokeWeight(2);
  fill(0);
  rect(STRENGTH_METER_XPOS, height/2, STRENGTH_METER_WIDTH, STRENGTH_METER_HEIGHT);
  fill(255,0,0);
  noStroke();
  rect(STRENGTH_METER_XPOS,height/2 + (1-currentStrengthFactor)*STRENGTH_METER_HEIGHT/2 ,STRENGTH_METER_WIDTH, currentStrengthFactor*STRENGTH_METER_HEIGHT);
  text("Strength", STRENGTH_METER_XPOS - 30, STRENGTH_METER_YPOS + STRENGTH_METER_HEIGHT/2 + 20);
}

void drawGravityAndAIStatus()
{
  fill(255,0,0);
  if(isGravityOn)
  {
    text("GRAVITY ON",STRENGTH_METER_XPOS - 50, 30);
  }else
  {
    text("GRAVITY OFF",STRENGTH_METER_XPOS -50, 30);
  } 
  
  if(isAIModeOn)
  {
    text("AI ON", STRENGTH_METER_XPOS - 50, 50);
  }else
  {
    text("AI OFF", STRENGTH_METER_XPOS - 50, 50);
  }
}

void drawPockets()
{
   line(CARROM_BOARD_WIDTH-EDGE_SIZE-POCKET_SIZE, EDGE_SIZE,CARROM_BOARD_WIDTH-EDGE_SIZE-POCKET_SIZE , EDGE_SIZE+POCKET_SIZE);
   line(CARROM_BOARD_WIDTH-EDGE_SIZE-POCKET_SIZE, EDGE_SIZE+POCKET_SIZE,CARROM_BOARD_WIDTH-EDGE_SIZE,EDGE_SIZE+POCKET_SIZE);
   
   line(CARROM_BOARD_WIDTH-EDGE_SIZE-POCKET_SIZE, CARROM_BOARD_HEIGHT-EDGE_SIZE-POCKET_SIZE, CARROM_BOARD_WIDTH-EDGE_SIZE-POCKET_SIZE, CARROM_BOARD_HEIGHT-EDGE_SIZE);
   line(CARROM_BOARD_WIDTH-EDGE_SIZE-POCKET_SIZE,CARROM_BOARD_HEIGHT-EDGE_SIZE-POCKET_SIZE, CARROM_BOARD_WIDTH-EDGE_SIZE, CARROM_BOARD_HEIGHT-EDGE_SIZE-POCKET_SIZE);
   
   line(EDGE_SIZE, CARROM_BOARD_HEIGHT-EDGE_SIZE-POCKET_SIZE, EDGE_SIZE+POCKET_SIZE,CARROM_BOARD_HEIGHT-EDGE_SIZE-POCKET_SIZE);
   line(EDGE_SIZE+POCKET_SIZE,CARROM_BOARD_HEIGHT-EDGE_SIZE-POCKET_SIZE,EDGE_SIZE+POCKET_SIZE,CARROM_BOARD_HEIGHT-EDGE_SIZE);
   
   line(EDGE_SIZE,EDGE_SIZE+POCKET_SIZE,EDGE_SIZE+POCKET_SIZE,EDGE_SIZE+POCKET_SIZE);
   line(EDGE_SIZE+POCKET_SIZE,EDGE_SIZE,EDGE_SIZE+POCKET_SIZE,EDGE_SIZE+POCKET_SIZE);
}

void displayCoins()
{
  for(Boundary edge : boundaries)
  {
    edge.display();
  }
  if(level == 1)
  {
    for( Boundary obs : obstructions)
    {
      obs.display();
    }
  }
  
  for(CarromMen whiteM : whiteMen)
  {
    if(isAIModeOn)
    {
      whiteM.attractToCenter(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT/2);
    }
    whiteM.display();
  }
  for(CarromMen blackM : blackMen)
  {
    if(isAIModeOn)
    {
      blackM.attractToCenter(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT/2);
    }
    blackM.display();
  }
  
  if(isAIModeOn)
  {    
    queen.attractToCenter(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT/2);
  }
  if(isQueenToBeShown && !isQueenPocketed)
  {
    queen.display();
  }
  striker.display();
}

void displayScore()
{
   text("W" + " "+str(whiteScored+queenScoreW), STRENGTH_METER_XPOS - 50, 80);
   text("B"+ "  "+str(blackScored+queenScoreB), STRENGTH_METER_XPOS - 50, 100);
   text("BONUS" + "  " + str(bonusPoint), STRENGTH_METER_XPOS - 50, 130);
   text("TOTAL" + "  " + str(blackScored+queenScoreB+bonusPoint), STRENGTH_METER_XPOS - 50, 160);
   text("STRIKER LEFT " + strikerChancesLeft, STRENGTH_METER_XPOS - 50, 200);
   text("'H' for Help ", STRENGTH_METER_XPOS - 50, 440);
   if(isMute)
   {
     text("Sound OFF",STRENGTH_METER_XPOS - 50, 480);
   }
   else
   {
     text("Sound ON",STRENGTH_METER_XPOS - 50, 480);
   }
   text(queenStatus , STRENGTH_METER_XPOS - 50, 510);
   text("LEVEL: " + str(level+1), STRENGTH_METER_XPOS - 50, 530);
   text("Motion Status: " , STRENGTH_METER_XPOS -50, 560);
   if(checkIfMotionStopped())
   {
      text("Not Moving" , STRENGTH_METER_XPOS -50, 580);
   }
   else
   {
     text("Moving ", STRENGTH_METER_XPOS -50, 580);
   }
}

void displayGameOver(int result)
{
   textSize(42);
   fill(0,0,0,80);
   rect(CARROM_BOARD_WIDTH/2,CARROM_BOARD_HEIGHT/2,CARROM_BOARD_WIDTH, CARROM_BOARD_HEIGHT); 
   fill(0,255,0);
   if(result == LOSE_RESULT)
  {
    text("G A M E   O V E R", CARROM_BOARD_WIDTH/2 - 170, CARROM_BOARD_HEIGHT/2);
  }else if (result == WIN_RESULT)
  {
    text("Y  O  U    W  I  N", CARROM_BOARD_WIDTH/2 - 170, CARROM_BOARD_HEIGHT/2);
  }
   textSize(16);
}
