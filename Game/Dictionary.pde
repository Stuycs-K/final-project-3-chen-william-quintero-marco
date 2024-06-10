public class Dictionary extends Mob{
  public Dictionary(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 75;
    speed = 8;
    velocity = new PVector(speed, 0);
    mobName = "Dictionary";
    mobImage = loadImage("Dictionary.png");
    
  }
  public int getType(){
    return 8;
  }
}
