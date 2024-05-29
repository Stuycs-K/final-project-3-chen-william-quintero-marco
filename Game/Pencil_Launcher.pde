public class Pencil_Launcher extends Tower{
  public Pencil_Launcher(float x, float y){
    super(x,y);
    damage = 3;
    radius = 5;
    attackSpeed = 1;
    cost = 300;
  }
  public void attack(){
    return;
  }
  
  public void place(){
    return;
    fill(0);
    noStroke();
    circle(coordX, coordY, 50);
  }
}
