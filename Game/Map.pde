import java.util.*;
public class Map{
  private Tile[][] map;
  private LinkedList<Tile> path = new LinkedList<Tile>();
  private ArrayList<Tile> corners = new ArrayList<Tile>();
  private int mapWidth;
  private int mapLength;
  public Map(int row, int col, int w, int l){
    map = new Tile[row][col];
    mapWidth = w;
    mapLength = l;
    for (int i = 0; i < row; i++){
      for (int j = 0; j < col; j++){
        if (j == 7 && i >= 0 && i <= 13 || j <= 7 && j >= 3 && i == 13 || j == 3 && i <= 13 && i >= 9 || j <= 13 && j >= 3 && i == 9 || j == 13 && i >= 5 && i <= 9 || j <= 13 && j >= 9 && i == 5 || j == 9 && i <= 16 && i >= 5 || j >= 5 && j <= 9 && i == 16 || j == 5 && i <= 20 && i >= 16 || j <= 11 && j >= 5 && i == 20 || j == 11 && i >= 14 && i <= 20 || j >= 11 && j <= 18 && i == 14){
          if (j == 7 && i == 13 || j == 3 && i == 13 || j == 3 && i == 9 || j == 13 && i == 9 || j == 13 && i == 5 || j == 9 && i == 5 || j == 9 && i == 16 || j == 5 && i == 16 || j == 5 && i == 20 || j == 15 && i == 20 || j == 11 && i == 20 || j == 11 && i == 14){
            CornerTile nt = new CornerTile(i * mapWidth / row, j * mapLength / col);
            map[i][j] = nt;
            corners.add(map[i][j]);
          }
          else{
            PathTile nt = new PathTile(i * mapWidth / row, j * mapLength / col);
            map[i][j] = nt;
          }
          path.add(map[i][j]);
        }else{
          map[i][j] = new GrassTile(i * mapWidth / row, j * mapLength / col);
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
  public Tile getFirstPath(){
    return path.getFirst();
  }
  public Tile getPathAt(int pos){
    return path.get(pos);
  }
  public int findCorner(float x, float y){
    for (int i = 0; i < corners.size(); i++){
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
