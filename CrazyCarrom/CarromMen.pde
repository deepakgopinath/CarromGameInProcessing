class CarromMen
{
  Body b;
  float radius;
  color col;
  AudioSample sound;
  
  CarromMen(float startX, float startY, float r, int whatIsIt, String soundFile)
  {
    radius = r;
    makebody(startX, startY, r);
    sound = minim.loadSample(soundFile, BUFFERSIZE);
    b.setUserData(this); //This is useful to retreive info about this class during collisions.
    if(whatIsIt == IS_BLACK)
    {
      col = color(80,80,80); 
    } 
    else if(whatIsIt == IS_WHITE)
    {
      col = color(224,181,52); 
    }else if(whatIsIt == IS_RED)
    {
      col = color(235,33,221); 
    }
    sound.mute(); 
  }
  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(b);
    float a = b.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, 2*radius, 2*radius); // Draw the coin
    line(0,0,radius,0); // Draw the orientation pointer!
    popMatrix(); 
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
      killBody();
      return true;
    } else {
    return false;
    }
  
  }
  
  void makebody(float x,float y, float rad)
  {
    CircleShape c = new CircleShape();
    c.setRadius(box2d.scalarPixelsToWorld(rad));
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = c;
    fd.density = 0.1;
    fd.friction = 0.2;
    fd.restitution = random(40,50)/100;
    
    b.createFixture(fd);
    Vec2 linVel = new Vec2(0,0);
    b.setLinearVelocity(linVel);
    b.setLinearDamping(LINEAR_DAMPING_CARROMMEN);
    b.setAngularDamping(ANGULAR_DAMPING_CARROMMEN);
 
  }
  
  float velocityRetrieve()
  {
    Vec2 linVel = b.getLinearVelocity();
    return linVel.length();
  }
  void resetVelocity()
  {
    b.setLinearVelocity(new Vec2(0,0));
    b.setAngularVelocity(0);
  }
  
  void attractToCenter(float centerX, float centerY) //For AI mode...
  {
    Vec2 worldTarget = box2d.coordPixelsToWorld(centerX, centerY); // target is the center of the baord;
    Vec2 bodyVec = b.getWorldCenter(); //Where is the body right now in world coordinates;
    
    worldTarget.subLocal(bodyVec); // Find the difference vector
    worldTarget.normalize();
    worldTarget.x *= (float)random(0,1);
    worldTarget.y *= (float)random(0,1);
    b.applyForce(worldTarget, bodyVec);
  }
  
  void play()
  {
    sound.trigger();
  }
}

