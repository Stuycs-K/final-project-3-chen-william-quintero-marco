public class PathTile extends Tile{
  private boolean hasMob;
  public PathTile(float x, float y){
    super(x, y);
    boolean hasMob = false;
  }
  public placeMob(){
    hasMob = false;
  }
}
