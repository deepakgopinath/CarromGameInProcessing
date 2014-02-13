void beginContact(Contact cp)
{
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if(!isMute)
  { 
    if(o1.getClass() == CarromMen.class && o2.getClass() == CarromMen.class) 
     {
       CarromMen c1 = (CarromMen)o1;
       c1.play();
       CarromMen c2 = (CarromMen)o2;
       c2.play();
     }
     if(o1.getClass() == Striker.class && o2.getClass() == CarromMen.class)
     {
       Striker c1 = (Striker)o1;
       c1.play();
       CarromMen c2 = (CarromMen)o2;
       c2.play();
     }
     if(o1.getClass() == CarromMen.class && o2.getClass() == Striker.class)
     {
       CarromMen c1 = (CarromMen)o1;
       c1.play();
       Striker c2 = (Striker)o2;
       c2.play();
     }
  }
}  

void endContact(Contact cp)
{

}
