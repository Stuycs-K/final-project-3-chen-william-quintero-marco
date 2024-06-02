public class Pencil_Launcher extends Tower{
  public Pencil_Launcher(float x, float y,Map map){
    super(x,y,map);
    towerName = "Pencil Launcher";
    damage = 3;
    radius = 5;
    attackSpeed = 1;
    cost = 300;
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
      circle(coordX+25, coordY+25, 50);
    }
  }
  
}
