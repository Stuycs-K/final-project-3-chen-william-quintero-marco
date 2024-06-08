import java.util.*;
public class Mob{
  PVector position, velocity;
  private float radius;
  int health;
  String type;
  ArrayList<PathTile> path;
  PathTile currentTile;
  int currentCorner = 0;
  boolean broke = false;
  boolean slowed = false;
  float speed;
  public Mob(float x, float y, float radius, String type, Map map){
    position = new PVector(x, y);
    this.radius = radius;
    speed = 5;
    velocity = new PVector(5, 0);
    health = 20;
    this.type = type;
    path = map.getPath();
    currentTile = map.getPath().get(0);
    currentTile.setMob(this);
  }
  public void display(){
    fill(200, 0, 0);
    circle(position.x, position.y, radius);
  }
  public void move(){
    position.add(velocity);
  }
  public void changeDirection(float x, float y, int corner){
    PVector newVelocity;
    if (corner % 2 == 0){
      newVelocity = new PVector(0, y / Math.abs(y));
    }else{
      newVelocity = new PVector(x / Math.abs(x), 0);
    }
    newVelocity.mult(speed);
    velocity = newVelocity;
  }
  public float getX(){
    return position.x;
  }
  public float getY(){
    return position.y;
  }
  public void changePosition(float x, float y){
    position = new PVector(x, y);
  }
  public int getHealth(){
    return health;
  }
  public PVector getVelocity(){
    return velocity;
  }
  public void applyDamage(int damage){
    if (health - damage < 0){
      health = 0;
    }else{
      health -= damage;
    }
  }
  public PathTile getCurrentTile(){
    return currentTile;
  }
  public void setCurrentTile(float x, float y){
    for (int i = 0; i < path.size(); i++){
      if (Math.abs(path.get(i).getX() - x) <= 25 && Math.abs(path.get(i).getY() - y) <= 25){
        currentTile.removeEntity();
        currentTile = path.get(i);
      }
    }
    currentTile.setMob(this);
    currentTile.placeEntity();
  }
  public void changeVelocity(float speed){
    if(!slowed){
    if(velocity.x == 0){
      velocity = new PVector(0, speed);
      this.speed = speed;
    }else{
      velocity = new PVector(speed, 0);
      this.speed = speed;
    }
    slowed = true;
    }
  }
  public int getCorner(){
    return currentCorner;
  }
  public void changeCorner(){
    currentCorner++;
  }
  public int getType(){
    return 0;
  }
  public void breakMob(){
    broke = true;
  }
  public boolean isBroke(){
    return broke;
  }
}
