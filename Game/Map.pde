public class Map{
  private Tile[][] map;
  private LinkedList<Tile>
  private int mapWidth;
  private int mapLength;
  public Map(int row, int col, int w, int l){
    map = new Tile[row][col];
    for (int i = 0; i < row; i++){
      for (int j = 0; j < col; j++){
        map[i][j] = new Tile(i * w / col, j * l / row);//calculate this later
      }
    }
  }
  public drawMap(){
    
  }
}
