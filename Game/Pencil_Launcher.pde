public class Pencil_Launcher extends Tower{
  public Pencil_Launcher(float x, float y,Map map){
    super(x,y,map);
    towerName = "Pencil Launcher";
    damage = 3;
    radius = 5;
    attackSpeed = 1;
    cost = 300;
  }
  public boolean findEnemy(){
      for (int i = path.toArray().length-1; i >= 0; i--){
        PathTile pathTile = path.get(i);
        if (pathTile.hasEntity()){
          if (Math.abs(tileX - pathTile.getTileX()) <= radius && Math.abs(tileY - pathTile.getTileY()) <= radius){
             targetMob = pathTile.getMob();
             return true;
          }
        }
      }
    
    return false;
  }
  public void attack(){
    //PVector pencilPos = new PVector(coordX,coordY);
    //PVector velocity = new PVector(0,0);
    //PVector enemyPos = new PVector(0,0);
    if (findEnemy()){
      targetMob.applyDamage((int)damage);
      System.out.println(targetMob.getHealth());
    }
    //pencilPos.add(velocity);
    //circle(pencilPos.x,pencilPos.y,10);
    
    //delay((int)(attackSpeed*1000));
  }
  
  public void display(){
    if (placed){
      fill(0);
      noStroke();
      circle(coordX+25, coordY+25, 50);
    }
  }
  
}
