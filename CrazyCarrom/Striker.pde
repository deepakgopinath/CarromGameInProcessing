class Striker
{
  Body b;
  float radius;
  color col;
  boolean isMoving;
  float anglePointer;
  float shotStrength;
  float aimVectorLength;
  AudioSample sound;
  boolean isWithinTranslationDist;
  
  Striker(float startX, float startY, float r, String soundFile)
  {
    radius = r;
    makebody(startX, startY, radius);
    b.setUserData(this);
    col = color(230,221,197);
    sound = minim.loadSample(soundFile, BUFFERSIZE);
    isMoving = false;
    anglePointer = -PI/2;
    shotStrength = MIN_SHOT_STRENGTH;
    isWithinTranslationDist = true;
    sound.mute();
  }
  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(b);
    anglePointer = b.getAngle();
    float a = b.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, 2*radius, 2*radius);
    
    if(!isMoving && isWithinTranslationDist == false)
    {
      pushMatrix();
      translate(0, radius);
      float rotAngle = atan(radius/aimVectorLength);
      float distance = sqrt(pow(radius,2) + pow(aimVectorLength,2));
      rotate(-rotAngle);
      line(0,0, distance, 0);
      rotate(rotAngle);
      translate(0,-2*radius);
      rotate(rotAngle);
      line(0,0, distance, 0);
      popMatrix();
      
    }
    popMatrix(); 
  }
  void makebody(float x, float y, float r)
  {
    CircleShape c = new CircleShape();
    c.setRadius(box2d.scalarPixelsToWorld(r));
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = c;
    fd.density = 0.3;
    fd.friction = 0.2;
    fd.restitution = random(60,80)/100.0;
    
    b.createFixture(fd);
    Vec2 linVel = new Vec2(0,0);
    b.setLinearVelocity(linVel);
    b.setLinearDamping(LINEAR_DAMPING_STRIKER);
    b.setAngularDamping(ANGULAR_DAMPING_STRIKER);
    b.setGravityScale(0);
  }

  float velocityRetrieve()
  {
    Vec2 linVel = b.getLinearVelocity();
    return linVel.length();
  }
  void resetPosition()
  {
   // b.setType(BodyType.STATIC); // so that on reset it doesnt move the coins in the way
    b.setActive(false);
    b.setLinearVelocity(new Vec2(0,0));
    b.setAngularVelocity(0);
    anglePointer = -PI/2;
    shotStrength = MIN_SHOT_STRENGTH;
    Vec2 position = new Vec2(box2d.coordPixelsToWorld(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT - CARROM_STRIKE_AREA_DIST_FROM_EDGE));
    b.setTransform(position, anglePointer);
    isWithinTranslationDist =  true;
    isMoving = false;
  }
  void killBody()
  {
    box2d.destroyBody(b);
  }
 boolean isDone()
  {
    Vec2 currentPos = box2d.getBodyPixelCoord(b);
    if(checkIfPocketed(currentPos.x, currentPos.y))
    {
      strikerChancesLeft--;
      if(strikerChancesLeft == 0)
      {
        isGameOver = true;
        finalResult = LOSE_RESULT;
      }
      return true;
    }else
    {
      return false;
    }
  }  

  void moveAlongXAndSetShotDirection(float mousePosX, float mousePosY)
  {  
    Vec2 mousePosInWorld = box2d.coordPixelsToWorld(mousePosX, mousePosY);
    Vec2 bodyPos = b.getWorldCenter();
    Vec2 bodyPosInPixels = box2d.coordWorldToPixels(bodyPos);
    //println(mousePosInWorld.x + " " + mousePosInWorld.y + " " + bodyPos.x + " " + bodyPos.y);
    //if the mouse is within the striker area only do translation if is it outside do rotation
    if(dist(mouseX, mouseY, bodyPosInPixels.x, bodyPosInPixels.y) <= 2*CARROM_STRIKER_RADIUS)
    {
      isWithinTranslationDist = true;
      bodyPos.x = mousePosInWorld.x;
      if(bodyPos.x < -22.42 )
      {
        bodyPos.x = -22.42;
      }
      if(bodyPos.x > 7.22)
      {
        bodyPos.x = 7.22;
      }
      aimVectorLength = 0;
    }else
    {
      isWithinTranslationDist = false;
      anglePointer = atan2(mouseY - bodyPosInPixels.y, mouseX - bodyPosInPixels.x);
      aimVectorLength = dist(mouseX, mouseY, bodyPosInPixels.x, bodyPosInPixels.y);
    }
   
    aimVectorLength = constrain(aimVectorLength, 32, 105);
    //println(aimVectorLength);
    currentStrengthFactor = abs(map(aimVectorLength, 32, 105, 0, 1));
    //println(currentStrengthFactor);
    b.setTransform(bodyPos, anglePointer);
  }
  
  void hit()
  {
    currentShotLog.clear(); // Clear the shot log before every hit.
    b.setType(BodyType.DYNAMIC); // set dynamic
    b.setActive(true);
    isMoving = true;
    unmuteSounds();
    if(level == 1)
    {
      randomizePhysicsParams();
      randomizePhysicsParamsCarromMen();
    }
    
    Vec2 impulse = new Vec2(shotStrength*cos(-anglePointer+PI), shotStrength*sin(-anglePointer+PI));
    b.applyForceToCenter(impulse);
    aimVectorLength = 0;
    currentStrengthFactor = 0;
  }
  
  void randomizePhysicsParams()
  {
      b.setLinearDamping(random(3*LINEAR_DAMPING_STRIKER) + 0.1);
      b.setAngularDamping(random(3*ANGULAR_DAMPING_STRIKER) + 0.1);
      b.getFixtureList().setRestitution(random(1));
  }
  
  void play()
  {
    sound.trigger();
  }
}
