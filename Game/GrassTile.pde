public class GrassTile extends Tile{
  Tower currentTower;
  public GrassTile(float x, float y, int X, int Y){
    super(x, y, X, Y);
  }
  public int getType(){
    return 2;
  }
  public void setTower(Tower tower){
    currentTower = tower;
  }
  public Tower getTower(){
    return currentTower;
  }
}
