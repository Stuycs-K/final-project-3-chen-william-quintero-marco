public abstract class Tower{
  String towerName;
  float damage, radius, attackSpeed, cost;
  Tile towerTile;
  float coordX, coordY;
  int tileX,tileY;
  boolean placed;
  Map map;
  ArrayList<PathTile> path;
  //Mob targetMob;
  int cooldown;
  PImage towerImage;
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
  
  //public Mob getTargetMob(){
  //  return targetMob;
  //}
  
  //public void setTargetMob(Mob mob){
  //  targetMob = mob;
  //}
  
  public int getCooldown(){
    return cooldown;
  }
  
  public void setCooldown(int n){
    cooldown = n;
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
  
  public Mob findMob(){
    for (int i = path.size()-1; i >= 0; i--){
      PathTile pathTile = path.get(i);
      if (pathTile.hasEntity()){
        if (Math.abs(tileX - pathTile.getTileX()) <= radius && Math.abs(tileY - pathTile.getTileY()) <= radius){
          return pathTile.getMob();
        }
      }
    }
    return null;
  }
  public abstract boolean attack();
  public abstract void display();
  
}
