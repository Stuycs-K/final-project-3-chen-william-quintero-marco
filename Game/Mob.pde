public class Mob{
  private PVector position, velocity;
  private float radius;
  private int health;
  private String type;
  public Mob(float x, float y, float radius, String type){
    position = new PVector(x, y);
    this.radius = radius;
    velocity = new PVector(5, 0);
    health = 5;
    this.type = type;
  }
  public void display(){
    fill(200, 0, 0);
    circle(position.x, position.y, radius);
  }
  public void move(){
    position.add(velocity);
  }
  public void changeDirection(float x, float y){
    PVector newVelocity = new PVector(this.getX() - x, this.getY() - y);
    newVelocity.normalize();
    newVelocity.mult(5);
    velocity = newVelocity;
  }
  public float getX(){
    return position.x;
  }
  public float getY(){
    return position.y;
  }
  
}
