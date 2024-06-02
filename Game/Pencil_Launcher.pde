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
    PVector pencilPos = new PVector(coordX,coordY);
    PVector velocity = new PVector(0,0);
    PVector enemyPos = new PVector(0,0);
    for (int i = path.toArray().length-1; i >= 0; i--){
      Tile pathTile = path.get(i);
      if (pathTile.hasEntity()){
        enemyPos = new PVector(pathTile.getX(),pathTile.getY());
        velocity = PVector.sub(pencilPos,enemyPos);
      }
    }
    pencilPos.add(velocity);
    circle(pencilPos.x,pencilPos.y,10);

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
