void createWorld()
{
  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.setGravity(0,0);
  box2d.listenForCollisions();
 
  minim = new Minim(this);
}
void addBoundaries()
{
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT - EDGE_SIZE/2, CARROM_BOARD_WIDTH, EDGE_SIZE, false));
  boundaries.add(new Boundary(CARROM_BOARD_WIDTH/2, EDGE_SIZE/2, CARROM_BOARD_WIDTH, EDGE_SIZE, false));
  boundaries.add(new Boundary(CARROM_BOARD_WIDTH - EDGE_SIZE/2, CARROM_BOARD_HEIGHT/2, EDGE_SIZE, CARROM_BOARD_HEIGHT, false));
  boundaries.add(new Boundary(EDGE_SIZE/2, CARROM_BOARD_HEIGHT/2, EDGE_SIZE, CARROM_BOARD_HEIGHT, false)); 

}

void setCoinCoords()
{
  float x = CARROM_MEN_RADIUS;
  float offsetW = CARROM_BOARD_WIDTH/2;
  float offsetH = CARROM_BOARD_HEIGHT/2 - 5;
  
  if(level == 0)
  {
  
    CARROM_WHITEMEN_COORD[0][0] = offsetW; CARROM_WHITEMEN_COORD[0][1] = offsetH + 2*x;
    CARROM_WHITEMEN_COORD[1][0] = offsetW; CARROM_WHITEMEN_COORD[1][1] = offsetH + 4*x;
    CARROM_WHITEMEN_COORD[2][0] = offsetW; CARROM_WHITEMEN_COORD[2][1] = offsetH - 4*x;
    
    CARROM_WHITEMEN_COORD[3][0] = offsetW + sqrt(3)*x ; CARROM_WHITEMEN_COORD[3][1] = offsetH - x;
    CARROM_WHITEMEN_COORD[4][0] = offsetW - sqrt(3)*x ; CARROM_WHITEMEN_COORD[4][1] = offsetH - x;
    
    CARROM_WHITEMEN_COORD[5][0] = offsetW + 2*sqrt(3)*x ; CARROM_WHITEMEN_COORD[5][1] = offsetH - 2*x;
    CARROM_WHITEMEN_COORD[6][0] = offsetW + 2*sqrt(3)*x ; CARROM_WHITEMEN_COORD[6][1] = offsetH + 2*x;
    
    CARROM_WHITEMEN_COORD[7][0] = offsetW - 2*sqrt(3)*x ; CARROM_WHITEMEN_COORD[7][1] = offsetH - 2*x;
    CARROM_WHITEMEN_COORD[8][0] = offsetW - 2*sqrt(3)*x ; CARROM_WHITEMEN_COORD[8][1] = offsetH + 2*x;
 
  //*************
  
  
    CARROM_BLACKMEN_COORD[0][0] = offsetW; CARROM_BLACKMEN_COORD[0][1] = offsetH - 2*x;
    
    CARROM_BLACKMEN_COORD[1][0] = offsetW + sqrt(3)*x; CARROM_BLACKMEN_COORD[1][1] = offsetH - 1.5*x;
    CARROM_BLACKMEN_COORD[2][0] = offsetW + sqrt(3)*x; CARROM_BLACKMEN_COORD[2][1] = offsetH + x;
    CARROM_BLACKMEN_COORD[3][0] = offsetW + sqrt(3)*x; CARROM_BLACKMEN_COORD[3][1] = offsetH + 1.5*x;
    
    CARROM_BLACKMEN_COORD[4][0] = offsetW - sqrt(3)*x; CARROM_BLACKMEN_COORD[4][1] = offsetH - 1.5*x;
    CARROM_BLACKMEN_COORD[5][0] = offsetW - sqrt(3)*x; CARROM_BLACKMEN_COORD[5][1] = offsetH + x;
    CARROM_BLACKMEN_COORD[6][0] = offsetW - sqrt(3)*x; CARROM_BLACKMEN_COORD[6][1] = offsetH + 1.5*x;
    
    CARROM_BLACKMEN_COORD[7][0] = offsetW + 2*sqrt(3)*x; CARROM_BLACKMEN_COORD[7][1] = offsetH;
    CARROM_BLACKMEN_COORD[8][0] = offsetW - 2*sqrt(3)*x; CARROM_BLACKMEN_COORD[8][1] = offsetH;
  }
  if(level != 0)
  {
    CARROM_BLACKMEN_COORD[0][0] = offsetW; CARROM_BLACKMEN_COORD[0][1] = offsetH + 2*x;
    CARROM_BLACKMEN_COORD[1][0] = offsetW; CARROM_BLACKMEN_COORD[1][1] = offsetH + 4*x;
    CARROM_BLACKMEN_COORD[2][0] = offsetW; CARROM_BLACKMEN_COORD[2][1] = offsetH - 4*x;
    
    CARROM_BLACKMEN_COORD[3][0] = offsetW + sqrt(3)*x ; CARROM_BLACKMEN_COORD[3][1] = offsetH - x;
    CARROM_BLACKMEN_COORD[4][0] = offsetW - sqrt(3)*x ; CARROM_BLACKMEN_COORD[4][1] = offsetH - x;
    
    CARROM_BLACKMEN_COORD[5][0] = offsetW + 2*sqrt(3)*x ; CARROM_BLACKMEN_COORD[5][1] = offsetH - 2*x;
    CARROM_BLACKMEN_COORD[6][0] = offsetW + 2*sqrt(3)*x ; CARROM_BLACKMEN_COORD[6][1] = offsetH + 2*x;
    
    CARROM_BLACKMEN_COORD[7][0] = offsetW - 2*sqrt(3)*x ; CARROM_BLACKMEN_COORD[7][1] = offsetH - 2*x;
    CARROM_BLACKMEN_COORD[8][0] = offsetW - 2*sqrt(3)*x ; CARROM_BLACKMEN_COORD[8][1] = offsetH + 2*x;
    
    
    
    CARROM_WHITEMEN_COORD[0][0] = offsetW; CARROM_WHITEMEN_COORD[0][1] = offsetH - 2*x;
    
    CARROM_WHITEMEN_COORD[1][0] = offsetW + sqrt(3)*x; CARROM_WHITEMEN_COORD[1][1] = offsetH - 1.5*x;
    CARROM_WHITEMEN_COORD[2][0] = offsetW + sqrt(3)*x; CARROM_WHITEMEN_COORD[2][1] = offsetH + x;
    CARROM_WHITEMEN_COORD[3][0] = offsetW + sqrt(3)*x; CARROM_WHITEMEN_COORD[3][1] = offsetH + 1.5*x;
    
    CARROM_WHITEMEN_COORD[4][0] = offsetW - sqrt(3)*x; CARROM_WHITEMEN_COORD[4][1] = offsetH - 1.5*x;
    CARROM_WHITEMEN_COORD[5][0] = offsetW - sqrt(3)*x; CARROM_WHITEMEN_COORD[5][1] = offsetH + x;
    CARROM_WHITEMEN_COORD[6][0] = offsetW - sqrt(3)*x; CARROM_WHITEMEN_COORD[6][1] = offsetH + 1.5*x;
    
    CARROM_WHITEMEN_COORD[7][0] = offsetW + 2*sqrt(3)*x; CARROM_WHITEMEN_COORD[7][1] = offsetH;
    CARROM_WHITEMEN_COORD[8][0] = offsetW - 2*sqrt(3)*x; CARROM_WHITEMEN_COORD[8][1] = offsetH;
    
  }
  
}

void  getCoinsReady()
{
  whiteMen = new ArrayList<CarromMen>();
  for(int i=0; i<NUM_CARROM_WHITEMEN; i++)
  {
    whiteMen.add(new CarromMen(CARROM_WHITEMEN_COORD[i][0], CARROM_WHITEMEN_COORD[i][1], CARROM_MEN_RADIUS, IS_WHITE, (String)whiteSounds.get(i)));
  }
  
  blackMen = new ArrayList<CarromMen>();
  for(int i=0; i<NUM_CARROM_BLACKMEN; i++)
  {
    blackMen.add(new CarromMen(CARROM_BLACKMEN_COORD[i][0],CARROM_BLACKMEN_COORD[i][1], CARROM_MEN_RADIUS, IS_BLACK, (String)blackSounds.get(i)));
  }
  
  striker = new Striker(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT - CARROM_STRIKE_AREA_DIST_FROM_EDGE, CARROM_STRIKER_RADIUS, strikerSound);
  queen = new Queen(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT/2 - 5, CARROM_MEN_RADIUS, IS_RED, queenSound);

}

void createShotLogArray()
{
  currentShotLog = new ArrayList<Integer>();
}

void getSoundsReady()
{
  whiteSounds = new ArrayList<String>();
  for(int i=0; i<NUM_CARROM_WHITEMEN; i++)
  {
    String soundFileName = "W" + str(i+1) + ".wav";
    whiteSounds.add(soundFileName);
  }
  
  blackSounds = new ArrayList<String>();
  for(int i=0; i<NUM_CARROM_BLACKMEN; i++)
  {
    String soundFileName = "B" + str(i+1) + ".wav";
    blackSounds.add(soundFileName);
  }
  
  strikerSound = "S.wav";
  queenSound = "Q.wav";
}

void addObstructions()
{
   obstructions = new ArrayList<Boundary>();
  
  obstructions.add(new Boundary(CARROM_BOARD_WIDTH/4, CARROM_BOARD_HEIGHT/4, OBS_LONG_DIM + random(5), OBS_SHORT_DIM + random(5), true));
  obstructions.add(new Boundary(CARROM_BOARD_WIDTH/4 - 10, 3*CARROM_BOARD_HEIGHT/4 - 30, OBS_SHORT_DIM + random(5), OBS_LONG_DIM + random(5), true));
  obstructions.add(new Boundary(3*CARROM_BOARD_WIDTH/4,  CARROM_BOARD_HEIGHT/4, OBS_SHORT_DIM + random(5), OBS_LONG_DIM + random(5), true));
  obstructions.add(new Boundary(3*CARROM_BOARD_WIDTH/4 + 30, 3*CARROM_BOARD_HEIGHT/4 - 10 , OBS_LONG_DIM + random(5), OBS_SHORT_DIM + random(5), true)); 
}
