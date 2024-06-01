public class Mob{
  private PVector position, velocity;
  private float radius;
  private int health;
  private String type;
  public Mob(float x, float y, float radius, String type){
    position = new PVector(x, y);
    this.radius = radius;
    velocity = new PVector(2, 0);
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
  public void changeDirection(){
    PVector newVelocity;
    if (velocity.x > 0){
      newVelocity = new PVector(0, velocity.x);
      velocity = newVelocity;
    }else{
      newVelocity = new PVector(velocity.y, 0);
      velocity = newVelocity;
    }
  }
  
}
