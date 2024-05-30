public abstract class Tower{
  float damage, radius, attackSpeed, cost;
  Tile towerTile;
  float coordX,coordY; //temporary coordinates until Map and Tile class are working
  public Tower(float x, float y, Map map){
    int tileX = (int)(x/50);
    int tileY = (int)(y/50);
    Tile placeTile = map.getTile(tileY, tileX);
    if (map.getMapWidth() > x && map.getMapLength() > y){
      if (placeTile.getType() == 2){
        if (!placeTile.hasUnit()){
          towerTile = placeTile;
          placeTile.placeUnit();
        }
      }   
    }
  }
  
  public float getCost(){
    return cost;
  }
  
  
  public abstract void attack();
  public abstract void place();
  
}
