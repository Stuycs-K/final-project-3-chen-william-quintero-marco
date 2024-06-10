public class StackOfBooks extends Mob{
  public StackOfBooks(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    health = 50;
    speed = 3;
    velocity = new PVector(speed, 0);
    mobName = "Stack of Books";
    mobImage = loadImage("Stack of Books.png");
  }
  public int getType(){
    return 6;
  }
}
