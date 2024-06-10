public class PathTile extends Tile{
  private Mob currentMob;
  public PathTile(float x, float y, int X, int Y){
    super(x, y, X, Y);
  }
  public int getType(){
    return 1;
  }
  public void setMob(Mob mob){
    currentMob = mob;
  }
  public Mob getMob(){
    return currentMob;
  }
}
