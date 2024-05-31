public class Pencil_Launcher extends Tower{
  public Pencil_Launcher(float x, float y,Map map){
    super(x,y,map);
    towerName = "Pencil Launcher";
    damage = 3;
    radius = 5;
    attackSpeed = 1;
    cost = 300;
  }
  public void attack(){
    PVector towerPos = new PVector(coordX,coordY);
    for (int i = path.toArray().length; i >= 0; i--){
      Tile pathTile = path.get(i);
      if (pathTile.hasEntity()){
        PVector enemyPos = new PVector(pathTile.getX(),pathTile.getY());
        PVector velocity = PVector.sub(enemyPos,towerPos);
      }
    }
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
