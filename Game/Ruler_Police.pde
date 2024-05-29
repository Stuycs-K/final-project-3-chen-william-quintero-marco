public class Ruler_Police extends Tower{
  public Ruler_Police(float x, float y){
    super(x,y);
    damage = 3;
    radius = 2;
    attackSpeed = 0.5;
    cost = 200;
  }
  public void attack(){
    return;
  }
  
  public void place(){
    fill(0);
    noStroke();
    square(coordX, coordY, 50);
  }
}
