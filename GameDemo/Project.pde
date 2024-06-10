public class Project extends Mob{
  public Project(float x, float y, float radius, String type, Map map){
    super(x, y, radius, type, map);
    speed = 5;
    velocity = new PVector(speed, 0);
    mobName = "Project";
    mobImage = loadImage("Project.png");
  }
  public int getType(){
    return 1;
  }
}
