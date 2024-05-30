public class GrassTile extends Tile{
  private boolean hasUnit;
  public GrassTile(float x, float y){
    super(x, y);
    hasUnit = false;
  }
  public boolean hasUnit(){
    return hasUnit;
  }
  public void placeUnit(){
    hasUnit = true;
  }
  public int getType(){
    return 2;
  }
}
