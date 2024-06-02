public abstract class Tower{
  String towerName;
  float damage, radius, attackSpeed, cost;
  Tile towerTile;
  float coordX, coordY;
  int tileX,tileY;
  boolean placed;
  Map map;
  LinkedList<Tile> path;
  public Tower(float x, float y, Map gameMap){
    coordX = x;
    coordY = y;
    tileX = (int)(x/50);
    tileY = (int)(y/50);
    map = gameMap;
    path = gameMap.getPath();
    placed = false;
  }
  
  public String getTowerName(){
    return towerName;
  }
  
  public float getDamage(){
    return damage;
  }
  
  public float getRadius(){
    return radius;
  }
  
  public float getAttackSpeed(){
    return attackSpeed;
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
         }
       }
    }
  }
  public abstract void attack();
  public abstract void display();
  
}
