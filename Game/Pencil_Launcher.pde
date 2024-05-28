public class Pencil_Launcher extends Tower{
  public Pencil_Launcher(float x, float y){
    super(x,y);
    damage = 3;
    radius = 5;
    attackSpeed = 1;
    cost = 300;
  }
  public void attack(){
    PShape pencil = createShape(ELLIPSE,coordX,coordY,10,10);
    PVector position = new PVector(coordX,coordY);
    PVector velocity = new PVector(10,10);
    
    
  }
  
  public void place(){
    fill(0);
    noStroke();
    circle(coordX, coordY, 50);
  }
}
