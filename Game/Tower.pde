public abstract class Tower{
  float damage, radius, attackSpeed, cost;
  Tile towerTile;
  float coordX,coordY; //temporary coordinates until Map and Tile class are working
  public Tower(float x, float y){
    
    coordX = x;
    coordY = y;
  }
  
  public float getCost(){
    return cost;
  }
  
  
  public abstract void attack();
  public abstract void place();
  
}
