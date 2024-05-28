import java.util.*;
public class Map{
  private int[][] map;
  private LinkedList<Integer> pathTile;
  private int mapWidth;
  private int mapLength;
  public Map(int row, int col, int w, int l){
    map = new int[row][col];
    mapWidth = w;
    mapLength = l;
    for (int i = 0; i < row; i++){
      for (int j = 0; j < col; j++){
        if (i == 7 && j == 0 || i == 7 && j == 13 || i == 3 && j == 13 || i == 3 && j == 9 || i == 13 && j == 9 || i == 13 && j == 5 || i == 9 && j == 5 || i == 9 && j == 16 || i == 5 && j == 16 || i == 5 && j == 20 || i == 11 && j == 20 || i == 11 && j == 14){
          map[i][j] = i * mapWidth / row;
          //pathTile.add(map[i][j]);
        }else{
        map[i][j] = i * mapWidth / row;
        }
      }
    }
  }
  
  public int getTile(int r, int c){
    return map[r][c];
  }
  public float getTileLength(){
    return map.length;
  }
  public void getMap(){
    for (int i = 0; i < map.length; i++){
        System.out.println(Arrays.toString(map[i]));
    }
  }
  public int getWidth(){
    return mapWidth;
  }
  public int getLength(){
    return mapLength;
  }
  public int mapDiff(){
    return mapLength / 32;
  }
}