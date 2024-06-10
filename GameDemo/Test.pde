public class Test extends Mob{
  public Test(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 40;
    speed = 5;
    velocity = new PVector(speed, 0);
    mobName = "Test";
    mobImage = loadImage("Test.png");
  }
  public int getType(){
    return 5;
  }
  public void applyDamage(int damage){
    if (health - 3 < 0){
      health = 0;
    }else{
      if (damage <= 3){
        health -= damage;
      }else{
        health -= 3;
      }
    }
  }
}
