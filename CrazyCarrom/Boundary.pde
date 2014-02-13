class Boundary
{
  
  float posX;
  float posY;
  float boundaryWidth;
  float boundaryHeight;
  boolean isObs;
  float addX, addY, perlinStepSize;
  
  
  Body b; // reference to the rigid body
  
  Boundary(float posX_, float posY_, float width_, float height_, boolean isObstruction)
  {
    addX = addY = 0;
    posX = posX_; // the centers of the box
    posY = posY_;
    boundaryWidth = width_;
    boundaryHeight = height_;
    isObs = isObstruction;
    //Define the polygon. 
    PolygonShape sd = new PolygonShape();    
    float box2dW = box2d.scalarPixelsToWorld(boundaryWidth/2); // we need half widths for the next line
    float box2dH = box2d.scalarPixelsToWorld(boundaryHeight/2);     
    sd.setAsBox(box2dW, box2dH);  //Each of the edge is just a box ( a rectangle)

    //The body has been defined now. 
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(posX, posY));
    b = box2d.createBody(bd);
    b.setUserData(this);
    // Now the polygonshape and body needs to be connected. through a fixture
    
    b.createFixture(sd, 1);
    
  }
  
  void display()
  {
    fill(127,27, 29);
    stroke(0);
    rectMode(CENTER);
    addX = addY = 0;
    if(isObs && isObsMove)
    {
      moveObs();
    }
    
    rect(posX+addX, posY+addY, boundaryWidth, boundaryHeight);
  }
  
  void moveObs()
  {
    if(frameCount%5 == 0 )
    {
      perlinStepSize +=  random(1);
      addX = map(noise(perlinStepSize), 0, 1, -40, 40);
      addY = map(noise(perlinStepSize + 3000), 0, 1, -32, 36);
    }
      
    b.setTransform(box2d.coordPixelsToWorld(posX+addX, posY+addY), 0);
  }
}
