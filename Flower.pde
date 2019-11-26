
class Flower {
  private boolean alive;
  private int x, y;
  private color colour;
  int aliveNeighbours;

  Flower(int x, int y, boolean alive) {
    this.x = x;
    this.y = y;
    this.alive = alive;
  }

  void setAlive(boolean alive) {
    this.alive = alive;
  }
  
  boolean getAlive(){
  return this.alive;
  }

  public void show() {
    // Draws the flower to the canvas
    if(alive){
      fill(255);
    }else{
      fill(0);
    }
    stroke(0);
    rect((x*gridsize)+1, (y*gridsize)+1, gridsize-2, gridsize-2);
  }

  public void update() {
    // Logic for the flower
    aliveNeighbours = getNeighbours(this.x, this.y);
    
    if (alive) {// if cell is "alive"
      if (aliveNeighbours < 2) {// Rule One. A living flower with less than two living neighbors is cut off. It dies.
        this.alive = false;
      } else if (aliveNeighbours < 4) { // Rule Two. A living flower with two or three living neighbors is connected. It lives.
        this.alive = true;
      } else {// Rule Three. A living flower with more than three living neighbors is starved and overcrowded. It dies.
        this.alive = false;
      }
    } else { // if cell is "dead"
      if (aliveNeighbours == 3) { //Rule Four. A dead flower with exactly three living neighbors is reborn. It springs back to life.
        this.alive = true;
      }
    }

    // Set colour based on alive or not
    if (this.alive) {
      colour = 255;
    } else {
      colour = 0;
    }
  }

  private int getNeighbours(int cellX, int cellY) {
    // Returns the number of neighbours that are alive.
    int count = 0;
    // a 3x3 grid is [-1+x, -1+y][x+1], y+1]
    for ( int x = -1; x < 2; x++){
      for( int y = -1; y < 2; y++){
        // Get x,y of the neighbour
        int nX = cellX + x; 
        int nY = cellY + y;
        if((cellY != nY) | (cellX != nX)){
          if(inBounds(nX, nY)){
            // if the flower is alive increment count
            if(flowers[nX][nY].getAlive()){
              count++;
            }
          }
        }
      }
    }
    return count;
  }

}
