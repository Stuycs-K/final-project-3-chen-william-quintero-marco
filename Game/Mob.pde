public class Mob{
  private float x;
  private float y;
  private float dx;
  private float dy;
  private int health;
  private String type;
  public Mob(String type){
    dx = 1;
    dy = 0;
    health = 5;
    this.type = type;
  }
  public void move(){
    x = x + dx;
    y = y + dy;
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
