                   //*******************Crazzzyyy Carrom*******************//
                    //*******************by DEEPAK GOPINATH******************//
                    
                    //************* Project 3 - Game Project ***************//
                    //********************  LMC 6310 ***********************//


///Goal is to pocket black carrom men and the queen. The queen has to be immediately followed up by the black. If white follows the queen, eventually you will lose
/// you can still continue to play and have fun!


//// Box2d physics library is used. You will have to download the add-on library PBox2D for this sketch to work.



import pbox2d.*;

import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.contacts.*;


//*************************************************//

//For the sounds..Minim library is being used.
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


//*************************************************//

PBox2D box2d; // Our 2-d world is declared.

//*************************************************//
Minim minim; // Our Minim object for sound stuff.
final int BUFFERSIZE = 256;

//*************************************************//
//Constants!!! 

final int SCREEN_WIDTH = 800;
final int SCREEN_HEIGHT = 600;

//*************************************************//
final int EDGE_SIZE= 40;
final int CARROM_BOARD_WIDTH = 640;
final int CARROM_BOARD_HEIGHT = 600;
final int CARROM_MEN_RADIUS = 14;
final int CARROM_STRIKER_RADIUS = 16;
final int CARROM_STRIKE_AREA_DIST_FROM_EDGE = 135;
final int OBS_LONG_DIM = 80;
final int OBS_SHORT_DIM = 13;

final float CARROM_MEN_VELOCITY_THRESHOLD = 0.3;
final float CARROM_STRIKER_VELOCITY_THRESHOLD = 0.3;
final int NUM_CARROM_WHITEMEN = 9;
final int NUM_CARROM_BLACKMEN = 9;
float [][] CARROM_WHITEMEN_COORD = new float[NUM_CARROM_WHITEMEN][2]; //Coordinates For the initial placement of the coins
float [][] CARROM_BLACKMEN_COORD = new float[NUM_CARROM_BLACKMEN][2];

final int IS_WHITE = 1;
final int IS_BLACK = 2;
final int IS_RED = 3;

//*************************************************//
final float LINEAR_DAMPING_CARROMMEN = 0.6;
final float ANGULAR_DAMPING_CARROMMEN = 0.2;

final float LINEAR_DAMPING_STRIKER = 0.7;
final float ANGULAR_DAMPING_STRIKER = 0.2;


//*************************************************//
//STRENGTH METER STUFF

final int MAX_SHOT_STRENGTH = 22000;
final int MIN_SHOT_STRENGTH = 0;

final int STRENGTH_METER_HEIGHT = 170;
final int STRENGTH_METER_WIDTH = 15;
final float STRENGTH_METER_XPOS = 700;
final float STRENGTH_METER_YPOS = SCREEN_HEIGHT/2;

//*************************************************//
//Pocket edges
final int POCKET_SIZE = 40;

final float TOP_RIGHT_LEFT_EDGE_X = CARROM_BOARD_WIDTH - EDGE_SIZE - POCKET_SIZE;
final float TOP_RIGHT_BOTTOM_EDGE_Y = EDGE_SIZE + POCKET_SIZE;

final float BOTTOM_RIGHT_LEFT_EDGE_X = CARROM_BOARD_WIDTH-EDGE_SIZE-POCKET_SIZE;
final float BOTTOM_RIGHT_TOP_EDGE_Y = CARROM_BOARD_HEIGHT - EDGE_SIZE -  POCKET_SIZE; 

final float BOTTOM_LEFT_RIGHT_EDGE_X = EDGE_SIZE + POCKET_SIZE;
final float BOTTOM_LEFT_TOP_EDGE_Y = CARROM_BOARD_HEIGHT - EDGE_SIZE -  POCKET_SIZE;

final float TOP_LEFT_RIGHT_EDGE_X = EDGE_SIZE + POCKET_SIZE;
final float TOP_LEFT_BOTTOM_EDGE_Y = EDGE_SIZE + POCKET_SIZE;

//*************************************************//
final float WORLD_GRAVITY = 0.4; // Max gravity strength in any direction!

//*************************************************//

final int WIN_RESULT = 0;
final int LOSE_RESULT = 1;
final int MAX_STRIKER_CHANCES = 3;

//*************************************************//
final int FORCED_RESET = 1;
final int NATURAL_RESET = 2;
//*************************************************//

float currentStrengthFactor = 0;
float strengthFactorIncr = 0.005;

//Some flags for different modes and checks for queen!
boolean isGravityOn = false;
boolean isAIModeOn = false;
boolean isQueenToBeShown = true;
boolean isGameOver = false;
boolean isQueenPocketed = false;
boolean isMute = true;
boolean isObsMove = false;

String queenStatus = "";
//*************************************************//

int whiteScored = 0;
int blackScored = 0;
int queenScoreB = 0;
int queenScoreW = 0;
int bonusPoint = 0;
int strikerChancesLeft = MAX_STRIKER_CHANCES;
int finalResult;

final int MAX_LEVEL = 1;

int level = 0; // current level

//*************************************************//

//Array declarations!
ArrayList<Boundary>boundaries;
ArrayList<Boundary>obstructions;
ArrayList<CarromMen>whiteMen;
ArrayList<CarromMen>blackMen;
ArrayList<String>whiteSounds;
ArrayList<String>blackSounds;
ArrayList<Integer>currentShotLog;

final int WHITE_SHOT = 1;
final int BLACK_SHOT = 2;
final int QUEEN_SHOT = 3;
final int STRIKER_SHOT = 4;


Striker striker;
String strikerSound;
Queen queen;
String queenSound;

//*************************************************//

final int OPENING_PAGE = 0;
final int CONTROLS_AND_RULES_PAGE = 1;
final int PLAY_PAGE = 2;
int startFlag = OPENING_PAGE;

//*************************************************//
PImage bgImage;

void setup()
{
  size(SCREEN_WIDTH,SCREEN_HEIGHT);
  smooth();
  bgImage = loadImage("bgCarrom.png");
  bgImage.filter(ERODE);
 
  createWorld();
  createShotLogArray();
  setCoinCoords();
  getSoundsReady();
  getCoinsReady();
 
  if(level == 1)
  {
    addObstructions();
  }
  addBoundaries();
 
  textSize(16);
  textAlign(LEFT);
}




void draw()
{
  background(0);
  
  
  if(startFlag == OPENING_PAGE)
  {
    displayOpeningPage();
  }else if(startFlag == CONTROLS_AND_RULES_PAGE)
  {
    displayHelpPage();
  }
  else if(startFlag == PLAY_PAGE)
  {
    stroke(0);
    box2d.step(); // Needed for the 2d world to work!!! 
    image(bgImage,0,0);
    drawPockets();
    displayCoins();
    removePocketed();
    if(striker.isDone()) // If striker is pocketed, reset everything!
    {
      resetAll(NATURAL_RESET);
    }
    if(checkIfMotionStopped() == true)
    { 
      if(striker.isMoving == true)
      {
        resetAll(NATURAL_RESET);
      }
    }
    
    if(!isGameOver)
    {
      getReadyToHit();
     
    }else
    {
      isAIModeOn = false;
      isGravityOn = false;
      displayGameOver(finalResult);
    }
    showStrengthMeter();
    drawGravityAndAIStatus();
    displayScore();
  }
}




