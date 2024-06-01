import java.util.*;
public class Mob{
  private PVector position, velocity;
  private float radius;
  private int health;
  private String type;
  public Mob(float x, float y, float radius, String type){
    position = new PVector(x, y);
    this.radius = radius;
    velocity = new PVector(1, 0);
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
    PVector newVelocity;
    if (x >= 1){
      newVelocity = new PVector(x / Math.abs(x), 0);
    }else{
      newVelocity = new PVector(0, y / Math.abs(y));
    }
    velocity = newVelocity;
  }
  public float getX(){
    return position.x;
  }
  public float getY(){
    return position.y;
  }
  
}
