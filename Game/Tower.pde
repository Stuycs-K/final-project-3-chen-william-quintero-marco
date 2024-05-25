public abstract class Tower{
  float damage, radius, attackSpeed, cost;
  Tile homeTile;
  public Tower(float x, float y){
    homeTile = new GrassTile(x,y);
    
  }
  
  public float getCost(){
    return cost;
  }
  public abstract void attack();
  public abstract void place();
  
}
