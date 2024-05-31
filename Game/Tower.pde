public abstract class Tower{
  float damage, radius, attackSpeed, cost;
  Tile towerTile;
  float coordX, coordY;
  int tileX,tileY;
  boolean placed;
  Map map;
  public Tower(float x, float y, Map gameMap){
    coordX = x;
    coordY = y;
    tileX = (int)(x/50);
    tileY = (int)(y/50);
    map = gameMap;
    placed = false;
  }
  
  public float getCost(){
    return cost;
  }
  
  public void place(){
    if (map.getMapWidth() > coordX && map.getMapLength() > coordY){
      Tile placeTile = map.getTile(tileX, tileY);
      if (placeTile.getType() == 2){
        if (!placeTile.hasEntity()){
          towerTile = placeTile;
          placeTile.placeEntity();
          coordX = towerTile.getX();
          coordY = towerTile.getY();
          placed = true;
          System.out.println(placed);
         }
       }
    }
  }
  public abstract void attack();
  public abstract void display();
  
}
