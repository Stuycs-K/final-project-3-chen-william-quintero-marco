public class Map{
  Tile[][] map;
  int mapWidth;
  int mapLength;
  public Map(int row, int col, int w, int l){
    map = Tile[row][col];
    for (int i = 0; i < row; i++){
      for (int j = 0; j < col; j++){
        map[i][j] = new Tile(row, col);//calculate this later
      }
    }
  }
}
