public class Tile{
  private float x;
  private float y;
  private int tileX;
  private int tileY;
  private boolean hasEntity;
  public Tile(float x, float y, int X, int Y){
    this.x = x;
    this.y = y;
    this.tileX = X;
    this.tileY = Y;
    this.hasEntity = false;
  }
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public float getTileX(){
    return tileX;
  }
  public float getTileY(){
    return tileY;
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
