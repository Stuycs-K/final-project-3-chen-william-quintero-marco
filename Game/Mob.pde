public class Mob{
  private float x;
  private float y;
  private float dx;
  private float dy;
  private float radius;
  private int health;
  private String type;
  public Mob(float x, float y, float radius, String type){
    this.x = x;
    this.y = y;
    this.radius = radius;
    dx = 50;
    dy = 0;
    health = 5;
    this.type = type;
  }
  public void display(){
    fill(200, 0, 0);
    circle(x, y, radius);
  }
  public void move(){
    x += dx;
    y += dy;
  }
  public void changeDirection(){
    if (dx > 0){
      dy = dx;
      dx = 0;
    }else{
      dx = dy;
      dy = 0;
    }
  }
  
}
