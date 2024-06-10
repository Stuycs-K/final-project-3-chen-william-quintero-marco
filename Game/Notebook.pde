public class Notebook extends Mob{
  public Notebook(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 6;
    speed = 2;
    velocity = new PVector(speed, 0);
    mobName = "Notebook";
    mobImage = loadImage("Notebook.png");
  }
  public int getType(){
    return 2;
  }
}
