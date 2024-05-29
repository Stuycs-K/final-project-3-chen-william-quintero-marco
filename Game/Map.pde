import java.util.*;
public class Map{
  private Tile[][] map;
  private LinkedList<PathTile> path;
  private int mapWidth;
  private int mapLength;
  public Map(int row, int col, int w, int l){
    map = new Tile[row][col];
    mapWidth = w;
    mapLength = l;
    for (int i = 0; i < row; i++){
      for (int j = 0; j < col; j++){
        if (i == 7 && j == 0 || i == 7 && j == 13 || i == 3 && j == 13 || i == 3 && j == 9 || i == 13 && j == 9 || i == 13 && j == 5 || i == 9 && j == 5 || i == 9 && j == 16 || i == 5 && j == 16 || i == 5 && j == 20 || i == 11 && j == 20 || i == 11 && j == 14){
          map[i][j] = new PathTile(i * mapWidth / row, j * mapLength / col);
          //pathTile.add(map[i][j]);
        }else{
          map[i][j] = new Tile(i * mapWidth / row, j * mapLength / col);
        }
      }
    }
  }
  
  public Tile getTile(int r, int c){
    return map[r][c];
  }
  public float getTileLength(){
    return float(map.length);
  }
}
