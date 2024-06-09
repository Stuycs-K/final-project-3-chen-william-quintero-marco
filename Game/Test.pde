public class Test extends Mob{
  public Test(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 200;
    speed = 3;
    velocity = new PVector(speed, 0);
    mobName = "Test";
    mobImage = loadImage("Test.png");
  }
  public int getType(){
    return 4;
  }
}
