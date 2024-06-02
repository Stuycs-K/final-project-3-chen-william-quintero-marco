import java.util.*;
public class Map{
  private Tile[][] map;
  private ArrayList<PathTile> path = new ArrayList<PathTile>();
  private ArrayList<Tile> corners = new ArrayList<Tile>();
  private int mapWidth;
  private int mapLength;
  public Map(int row, int col, int w, int l){
    map = new Tile[row][col];
    mapWidth = w;
    mapLength = l;
    for (int i = 0; i < row; i++){
      for (int j = 0; j < col; j++){
        if (j == 10){
          PathTile nt = new PathTile(i * mapWidth / row, j * mapLength / col, i, j);
          map[i][j] = nt;
          path.add(nt);
        }else{
          map[i][j] = new GrassTile(i * mapWidth / row, j * mapLength / col, i, j);
        }
      }
    }
  }
  
  public Tile getTile(int r, int c){
    return map[r][c];
  }
  public int getMapWidth(){
    return mapWidth;
  }
  public int getMapLength(){
    return mapLength;
  }
  public ArrayList<PathTile> getPath(){
    return path;
  }
  
  public Tile getFirstPath(){
    return path.get(0);
  }
  
  public Tile getPathAt(int pos){
    return path.get(pos);
  }
  
  public int findCorner(float x, float y){
    for (int i = 0; i < corners.size() - 1; i++){
      if (corners.get(i).getX() == x && corners.get(i).getY() == y){
        return i;
      }
    }
    return -1;
  }
  
  public Tile getCorner(int index){
    return corners.get(index);
  }
}
