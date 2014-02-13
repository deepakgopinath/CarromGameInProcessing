void keyPressed()
{
  if(key == 'G' || key == 'g') //Gravity toggle
  {
   
    if(!isGravityOn)
    { 
      float x = random(-WORLD_GRAVITY, WORLD_GRAVITY);
      float y = random(-WORLD_GRAVITY, WORLD_GRAVITY);
      //println(x + " " + y);
      box2d.setGravity(x, y);
    }else
    { 
      box2d.setGravity(0,0);
    }
    isGravityOn = !isGravityOn;
  }
  
  if(key == ' ') // Space bar to launch the striker in the play page
  {
    if(startFlag == PLAY_PAGE)
    {
      if(checkIfMotionStopped())
      { 
        //println("here");
        striker.shotStrength = currentStrengthFactor*(MAX_SHOT_STRENGTH - MIN_SHOT_STRENGTH) + MIN_SHOT_STRENGTH;
        if(strikerChancesLeft > 0)
          striker.hit();
      }
    }else
    {
      startFlag++;
    }
  }
  
  
    if(key == 'A' || key == 'a')
    {
      isAIModeOn = !isAIModeOn;
    }

  if(key == 'F' || key == 'f')
  {
    resetAll(FORCED_RESET);
  }
  
  if(key == 'H' || key == 'h')
  {
    startFlag = CONTROLS_AND_RULES_PAGE;
  }
  if(key == 'M' || key == 'm')
  {
    isMute = !isMute;
  }
  
  if(key == 'J' || key == 'j')
  {
    isObsMove = !isObsMove;
  }
}


void getReadyToHit() //Position the striker...
{ 
  if(checkIfMotionStopped())
  {
    if(mousePressed)
      {  
          striker.moveAlongXAndSetShotDirection(mouseX, mouseY);
      }
  }
}


