public class FinalTest extends Mob{
  public FinalTest(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 60;
    speed = 7;
    velocity = new PVector(speed, 0);
    mobName = "Final Test";
    mobImage = loadImage("Final Test.png");
  }
  public int getType(){
    return 7;
  }
  public void applyDamage(int damage){
    if (health - 2 < 0){
      health = 0;
    }else{
      if (damage <= 2){
        health -= damage;
      }else{
        health -= 2;
      }
    }
  }
}
