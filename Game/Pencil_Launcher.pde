public class Pencil_Launcher extends Tower{
  public Pencil_Launcher(float x, float y,Map map){
    super(x,y,map);
    damage = 3;
    radius = 5;
    attackSpeed = 1;
    cost = 300;
  }
  public void attack(){
    PVector position = new PVector(coordX,coordY);
    PVector velocity = new PVector(10,10);
    for (int i = 0; i < 10; i++){
      
    }
    //delay((int)(attackSpeed*1000));
  }
  
  public void place(){
    fill(0);
    noStroke();
    circle(coordX, coordY, 50);
  }
}
