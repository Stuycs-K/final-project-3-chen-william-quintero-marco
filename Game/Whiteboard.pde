public class Whiteboard extends Mob{
  public Whiteboard(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 40;
    speed = 3;
    velocity = new PVector(speed, 0);
    mobName = "Whiteboard";
    mobImage = loadImage("Whiteboard.png");
  }
  public int getType(){
    return 4;
  }
}
