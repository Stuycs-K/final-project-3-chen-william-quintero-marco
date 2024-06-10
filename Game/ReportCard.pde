public class ReportCard extends Mob{
  public ReportCard(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 100;
    speed = 5;
    velocity = new PVector(speed, 0);
    mobName = "Report Card";
    mobImage = loadImage("Report Card.png");
  }
  public int getType(){
    return 9;
  }
  public void applyDamage(int damage){
    if (health - 1 < 0){
      health = 0;
    }else{
      health--;
    }
  }
}
