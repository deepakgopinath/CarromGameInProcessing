void resetAll(int resetMode)
{
  //Check the coin list here? 
  for (int i=0; i<currentShotLog.size(); i++)
  {
    Integer currentInteger = currentShotLog.get(i);
    //println(currentInteger.intValue());
  }
  
  boolean t = checkIfQueenIsPocketedForReal();
  if (resetMode == FORCED_RESET)
  {
    striker.resetPosition();
  }else if(resetMode == NATURAL_RESET)
  {
    striker.resetPosition();
    queen.resetVelocity();
    for(CarromMen whiteM : whiteMen)
    {
      whiteM.resetVelocity();
    }
    for(CarromMen blackM : blackMen)
    {
      blackM.resetVelocity();
    }
  }      
}

void removePocketed()
{ 
  if(queen.isDone() && isQueenToBeShown == true)
  {
    isQueenToBeShown = false;
    queen.killBody();
    currentShotLog.add(new Integer(QUEEN_SHOT));
  }
  for(int i = whiteMen.size()-1; i>=0; i--)
  {
    CarromMen whiteM = (CarromMen)whiteMen.get(i);
    if(whiteM.isDone())
    {
      whiteScored++;
      currentShotLog.add(new Integer(WHITE_SHOT));
      whiteMen.remove(i);
      if(whiteScored == NUM_CARROM_WHITEMEN)
      {
        isGameOver = true;
        finalResult = LOSE_RESULT;
      }
    }
  }
   for(int i = blackMen.size()-1; i>=0; i--)
  {
    CarromMen blackM = (CarromMen)blackMen.get(i);
    if(blackM.isDone())
    {
      blackScored++;
      if(isAIModeOn || isGravityOn)
      {
        bonusPoint++;
      }
      currentShotLog.add(new Integer(BLACK_SHOT));
      blackMen.remove(i);
      if(blackScored == NUM_CARROM_BLACKMEN)
      {
        if(level < MAX_LEVEL)
        {  
          if(queenScoreB == 2 || (queenScoreW == 2 && ((blackScored + bonusPoint) >= (NUM_CARROM_BLACKMEN+2)))) // The queen was scored by black, therefore proceed to next level or the queen was scored by white but black managed to grab bonus points so therefore success
          {
            level++;
            resetForNewLevel(level);
            //finalResult = WIN_RESULT;
          }
          else
          {
            isGameOver = true;
            finalResult = LOSE_RESULT;
          }
        }else if(level == MAX_LEVEL)
          {
            if(queenScoreB == 2 || (queenScoreW == 2 && ((blackScored + bonusPoint) >= (NUM_CARROM_BLACKMEN+2)))) // The queen was scored by black, therefore proceed to next level or the queen was scored by white but black managed to grab bonus points so therefore success
            {
              isGameOver = true;
              finalResult = WIN_RESULT;
            }
            else
            {
              isGameOver = true;
              finalResult = LOSE_RESULT;
            }
            
          }
        }
      }
    }
  }  

void unmuteSounds()
{
  for(CarromMen whiteM : whiteMen)
    {
      whiteM.sound.unmute();
    }
    for(CarromMen blackM : blackMen)
    {
      blackM.sound.unmute();
    }
    
    if(isQueenToBeShown == true)
    {
      queen.sound.unmute();
    }
    striker.sound.unmute();
}

void randomizePhysicsParamsCarromMen()
{
    for(CarromMen whiteM : whiteMen)
    {
      whiteM.b.setLinearDamping(2*random(LINEAR_DAMPING_CARROMMEN) + 0.1);
      whiteM.b.setAngularDamping(2*random(ANGULAR_DAMPING_CARROMMEN) + 0.1);
      whiteM.b.getFixtureList().setRestitution(random(1));
    }
    for(CarromMen blackM : blackMen)
    {
      blackM.b.setLinearDamping(2*random(LINEAR_DAMPING_CARROMMEN) + 0.1);
      blackM.b.setAngularDamping(2*random(ANGULAR_DAMPING_CARROMMEN) + 0.1);
      blackM.b.getFixtureList().setRestitution(random(1));
    }
    if(isQueenToBeShown == true)
    {
      queen.b.setLinearDamping(2*random(LINEAR_DAMPING_CARROMMEN) + 0.1);
      queen.b.setAngularDamping(2*random(ANGULAR_DAMPING_CARROMMEN) + 0.1);
      queen.b.getFixtureList().setRestitution(random(1));
    }
}
void resetForNewLevel(int levelNumber)
{
  //reset scores;
  whiteScored = 0;
  blackScored = 0;
  queenScoreB = 0;
  queenScoreW = 0;
  strikerChancesLeft = MAX_STRIKER_CHANCES;
  queenStatus = "";
  bonusPoint = 0;
  
  //reset boolean
  isAIModeOn = true; // In LEVEL 1 have ai mode on all the time.   
  isGravityOn = false;
  isQueenToBeShown = true;
  isGameOver = false;
  isQueenPocketed = false;
  
  // reset arrays.
  currentShotLog.clear();
  currentShotLog = null;
  
  whiteMen.clear();
  whiteMen = null;
  
  blackMen.clear();
  blackMen = null;
  
  createShotLogArray();
  setCoinCoords();
  getCoinsReady();
  addObstructions();
  
}

