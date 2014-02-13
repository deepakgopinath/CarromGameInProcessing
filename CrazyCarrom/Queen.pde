class Queen extends CarromMen
{
  Queen(float startX, float startY, float r, int whatIsIt, String soundFile)
  {
    super(startX, startY, r, whatIsIt, soundFile);
  }
  
  boolean isDone()
  {
    Vec2 currentPos = box2d.getBodyPixelCoord(b);  
    return checkIfPocketed(currentPos.x, currentPos.y);
  }
  void killBody()
  {
    box2d.destroyBody(b);
  }
  void resetToCenter()
  {
    Vec2 centerPosition = box2d.coordPixelsToWorld(CARROM_BOARD_WIDTH/2, CARROM_BOARD_HEIGHT/2);
    b.setTransform(centerPosition, 0);
  }
}
