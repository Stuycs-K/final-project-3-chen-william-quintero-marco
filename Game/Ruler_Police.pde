public class Ruler_Police extends Tower{
  public Ruler_Police(float x, float y,Map map){
    super(x,y,map);
    towerName = "Ruler Police";
    damage = 5;
    radius = 2;
    attackSpeed = 1;
    cost = 200;
  }
  
  public boolean findEnemy(){
    return false;
  }
  
  public void attack(){
    return;
  }
  
  public void display(){
    if (placed){
      fill(0);
      noStroke();
      square(coordX, coordY, 50);
    }
  }
}
