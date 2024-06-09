public class Projectile{
  PVector position;
  PVector velocity;
  boolean fired;
  Mob target;
  PImage projectileImage;
  public Projectile(float x, float y, Mob targetMob, PImage image){
    position = new PVector(x,y);
    target = targetMob;
    PVector mobPos = new PVector(target.getX(),target.getY());
    velocity = PVector.sub(mobPos, position);
    velocity.normalize();
    velocity.mult(50);
    fired = false;
    projectileImage = image;
  }
  
  public PVector getPosition(){
    return position;
  }
  
  public void move(){
    position.add(velocity);
  }
  
  public void displayProjectile(){
    fill(255,255,0);
    noStroke();
    image(projectileImage,position.x,position.y);
  }
}
