public class PathTile extends Tile{
  private boolean hasMob;
  public PathTile(float x, float y){
    super(x, y);
    boolean hasMob = false;
  }
  public boolean hasMob(){
    return hasMob;
  }
  public void placeMob(){
    hasMob = true;
  }
  public int getType(){
    return 1;
  }
}
