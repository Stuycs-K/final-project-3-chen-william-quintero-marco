public class Tile{
  private float x;
  private float y;
  private int tileX;
  private int tileY;
  private boolean hasEntity;
  private String entityName;
  public Tile(float x, float y, int X, int Y){
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
  public void placeEntity(String name){
    hasEntity = true;
    entityName = name;
  }
  public String getEntityName(){
    return entityName;
  }
}
