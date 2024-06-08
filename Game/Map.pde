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
        if (j == 7 && i >= 0 && i <= 13 || j <= 7 && j >= 3 && i == 13 || j == 3 && i <= 13 && i >= 9 || j <= 13 && j >= 3 && i == 9 || j == 13 && i >= 5 && i <= 9 || j <= 13 && j >= 9 && i == 5 || j == 9 && i <= 16 && i >= 5 || j >= 5 && j <= 9 && i == 16 || j == 5 && i <= 20 && i >= 16 || j <= 11 && j >= 5 && i == 20 || j == 11 && i >= 14 && i <= 20 || j >= 11 && j <= 18 && i == 14){
          if (j == 7 && i == 13 || j == 3 && i == 13 || j == 3 && i == 9 || j == 13 && i == 9 || j == 13 && i == 5 || j == 9 && i == 5 || j == 9 && i == 16 || j == 5 && i == 16 || j == 5 && i == 20 || j == 11 && i == 20 || j == 11 && i == 14 || j == 17 && i == 14){
            CornerTile nt = new CornerTile(i * mapWidth / row, j * mapLength / col, i, j);
            map[i][j] = nt;
            path.add(nt);
          }else{
            PathTile nt = new PathTile(i * mapWidth / row, j * mapLength / col, i, j);
            map[i][j] = nt;
            path.add(nt);
          }
        }else{
          map[i][j] = new GrassTile(i * mapWidth / row, j * mapLength / col, i, j);
        }
      }
    }
    corners.add(map[13][7]);
    corners.add(map[13][3]);
    corners.add(map[9][3]);
    corners.add(map[9][13]);
    corners.add(map[5][13]);
    corners.add(map[5][9]);
    corners.add(map[16][9]);
    corners.add(map[16][5]);
    corners.add(map[20][5]);
    corners.add(map[20][11]);
    corners.add(map[14][11]);
    corners.add(map[14][17]);
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
      //(corners.get(i).getX() + 10 <= x && corners.get(i).getX() - 10 >= x && corners.get(i).getY() + 10 <= y && corners.get(i).getY() - 10 >= y) 
      if (corners.get(i).getX() == x && corners.get(i).getY() == y){
        return i;
      }
    }
    return -1;
  }
  public boolean nearCorner(float x, float y, int corner){
    return corners.get(corner).getX() + 20 >= x && corners.get(corner).getX() - 20 <= x && corners.get(corner).getY() + 20 >= y && corners.get(corner).getY() - 20 <= y;
  }
  public Tile getCorner(int index){
    return corners.get(index);
  }
}
