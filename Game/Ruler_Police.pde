public class Ruler_Police extends Tower{
  public Ruler_Police(float x, float y,Map map){
    super(x,y,map);
    towerName = "Ruler Police";
    damage = 5;
    radius = 2;
    attackSpeed = 1;
    cost = 200;
    cooldown = (int)(attackSpeed)*60;
  }
  
  public void attack(){
    for (int i = path.size()-1; i >= 0; i--){
      PathTile pathTile = path.get(i);
      if (pathTile.hasEntity()){
        if (Math.abs(tileX - pathTile.getTileX()) <= radius && Math.abs(tileY - pathTile.getTileY()) <= radius){
          pathTile.getMob().applyDamage((int)damage);
          System.out.println(pathTile.getMob().getHealth());
        }
      }
    }
    //if (findEnemy()){
    //  targetMob.applyDamage((int)damage);
    //  System.out.println(targetMob.getHealth());
    //}
  }
  
  public void display(){
    if (placed){
      fill(0);
      noStroke();
      square(coordX, coordY, 50);
    }
  }
}
