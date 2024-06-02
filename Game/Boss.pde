public class Boss extends Mob{
  public Boss(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
  }
  public void display(){
    fill(0, 0, 200);
    if (currentCorner % 2 == 0){
      ellipse(position.x, position.y, 150, 50);
    }else{
      ellipse(position.x, position.y, 50, 150);
    }
  }
}
