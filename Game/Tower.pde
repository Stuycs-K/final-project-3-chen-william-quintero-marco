public abstract class Tower{
  String towerName;
  float damage, radius, attackSpeed, cost;
  GrassTile towerTile;
  float coordX, coordY;
  int tileX,tileY;
  boolean placed;
  Map map;
  ArrayList<PathTile> path;
  ArrayList<GrassTile> grass;
  //Mob targetMob;
  int cooldown;
  PImage towerImage;
  int upgrade;
  boolean selected;
  public Tower(float x, float y, Map gameMap){
    coordX = x;
    coordY = y;
    tileX = (int)(x/50);
    tileY = (int)(y/50);
    map = gameMap;
    path = gameMap.getPath();
    grass = gameMap.getGrass();
    placed = false;
    upgrade = 0;
    selected = false;
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
  
  public PImage getTowerImage(){
    return towerImage;
  }
  
  public int getUpgrade(){
    return upgrade;
  }
  
  public void upgradeTower(){
    upgrade++;
  }
  
  public boolean getSelected(){
    return selected;
  }
  
  public void setSelected(boolean select){
    selected = select;
  }
  public GrassTile getTowerTile(){
    return towerTile;
  }
  
  public void place(){
    for (int i = 0; i < grass.size(); i++){
      if (coordX - grass.get(i).getX() <= 50 && coordY - grass.get(i).getY() <= 50){
        if (!grass.get(i).hasEntity()){
          towerTile = grass.get(i);
          towerTile.setTower(this);
          towerTile.placeEntity();
          coordX = towerTile.getX();
          coordY = towerTile.getY();
          placed = true;
          i = grass.size();
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
