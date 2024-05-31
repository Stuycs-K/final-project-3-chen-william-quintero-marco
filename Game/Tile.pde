public class Tile{
  private float x;
  private float y;
  private boolean hasEntity;
  public Tile(float x, float y){
    this.x = x;
    this.y = y;
    this.hasEntity = false;
  }
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public int getType(){
    return 0;
  }
  public boolean hasEntity(){
    return hasEntity;
  }
  public void placeEntity(){
    hasEntity = true;
  }
  
}
