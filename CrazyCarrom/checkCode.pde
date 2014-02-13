boolean checkIfMotionStopped()
{
//  checkIfQueenIsPocketedForSure();
  if(isGravityOn == false && isAIModeOn == false)
  {
    if(striker.velocityRetrieve() > CARROM_MEN_VELOCITY_THRESHOLD)
    {
      return false;
    }
    else if(queen.velocityRetrieve() > CARROM_MEN_VELOCITY_THRESHOLD && isQueenToBeShown == true)
    {
      return false;
    }
    else
    {
        for(CarromMen whiteM : whiteMen)
        {
          if(whiteM.velocityRetrieve() > CARROM_STRIKER_VELOCITY_THRESHOLD)
            return false;
        }
        for(CarromMen blackM : blackMen)
        {
          if(blackM.velocityRetrieve() > CARROM_STRIKER_VELOCITY_THRESHOLD)
            return false;
        }
        return true;
    }
  }else if(isGravityOn == true || isAIModeOn == true)
  {
    if(striker.velocityRetrieve() > CARROM_MEN_VELOCITY_THRESHOLD)
    {
      return false;
    }else
    {
      return true;
    }
  }
  return true;
}

boolean checkIfPocketed(float x, float y)
{
  if((x > TOP_RIGHT_LEFT_EDGE_X && y < TOP_RIGHT_BOTTOM_EDGE_Y) ||
     (x > BOTTOM_RIGHT_LEFT_EDGE_X && y > BOTTOM_RIGHT_TOP_EDGE_Y) ||
     (x < BOTTOM_LEFT_RIGHT_EDGE_X && y > BOTTOM_LEFT_TOP_EDGE_Y) ||
     (x < TOP_LEFT_RIGHT_EDGE_X && y < TOP_LEFT_BOTTOM_EDGE_Y))
  {
    return true;
  }else
  {
    return false;
  }
}


void checkStrengthFactorBounds()
{
  if(currentStrengthFactor > 1)
  {
    currentStrengthFactor = 1;
    strengthFactorIncr *= -1.0;
  }
  if(currentStrengthFactor < 0)
  {
    currentStrengthFactor = 0;
    strengthFactorIncr *= -1.0;
  }
}

boolean checkIfQueenIsPocketedForReal()
{
  if(isQueenToBeShown == true) // the queen is still on the board
  {
    return false; // So queen is not pocketed
  }
  else if(isQueenToBeShown == false && isQueenPocketed == false)  //Queen went in the pocket but awaiting confirmation. HAs not been followed up yet
  {  
    if(currentShotLog.size() > 0) // If at least one coin was pocketed in this shot
    {
      if(currentShotLog.contains(new Integer(QUEEN_SHOT)))
      {
        if(currentShotLog.size() == 1) // Only the queen was pocketed in this shot
        {
          return false;
        }else if(currentShotLog.size() > 1) // If there are more one 1 coin pocketed in a shot
        {
          int indexOfQueen = currentShotLog.indexOf(new Integer(QUEEN_SHOT));
          if(indexOfQueen == currentShotLog.size()-1) // If red was the last coin to be pocketed return, as we cannot decide it yet,
          {
            return false;
          }else
          { 
            if((Integer)currentShotLog.get(indexOfQueen + 1).intValue()== BLACK_SHOT)
            {
              isQueenPocketed = true; // The queen was pocketed for real. no need to instantiate a new queen. 
              queenScoreB = 2; // Because we have the red followed by black, increase black's score by 2
              queenStatus = "Queen Status: B";
              return true;
            }else
            {
              queenStatus = "Queen Status: W";
              isQueenPocketed = true;
              queenScoreW = 2;
//              isQueenToBeShown = true; // in this group shot the queen was not followed up immediately by a black, but instead by a white, so reset queen
//              queen = queen = new Queen(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT/2 - 5, CARROM_MEN_RADIUS, IS_RED, queenSound);
              return true;
             
            }
          }
        }  
      }else
      {
        if(currentShotLog.get(0) == BLACK_SHOT) // The red was pocketed earlier. check if the first coin in this shot was pocketed. 
        {
          isQueenPocketed = true; // pocketed for real.
          queenScoreB = 2;
          queenStatus = "Queen Status: B";
          return true;
        }
        else if(currentShotLog.get(0) == WHITE_SHOT)
        { 
          isQueenPocketed = true;
          queenScoreW = 2;
          queenStatus = "Queen Status: W";
          return true;
//          queen = new Queen(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT/2 - 5, CARROM_MEN_RADIUS, IS_RED, queenSound);
//          return false; 
        }
        
      }
    }else
    { 
      // If no coin was pokcted in this shot and the queen was pocketed in the previous shot the queen has to be reset to the center as it was not successfully followed up with a black
      isQueenToBeShown = true;
      queen = new Queen(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT/2 - 5, CARROM_MEN_RADIUS, IS_RED, queenSound);
      return false;
    }
  }
  return false;
  
}
