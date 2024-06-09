public class Textbook extends Mob{
  public Textbook(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 10;
    speed = 2;
    velocity = new PVector(speed, 0);
    mobName = "Textbook";
    mobImage = loadImage("Textbook.png");
  }
  public int getType(){
    return 2;
  }
}
