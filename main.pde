/*
A quick simulation of the flower game presented in the book of unveiling:
 https://www.ishtar-collective.net/entries/the-flower-game#book-unveiling
 
 
 These are the rules of a game. Let it be played upon an infinite two-dimensional grid of flowers.
 Rule One. A living flower with less than two living neighbors is cut off. It dies.
 Rule Two. A living flower with two or three living neighbors is connected. It lives.
 Rule Three. A living flower with more than three living neighbors is starved and overcrowded. It dies.
 Rule Four. A dead flower with exactly three living neighbors is reborn. It springs back to life.
 The only play permitted in the game is the arrangement of the initial flowers.
 
 */


Flower[][] flowers;
int rows, cols;
int gridsize = 10;
boolean mouseDown = false;
PVector mousePos = new PVector(0, 0);
int fps = 10;
boolean playing;

void setup() {
  // smooth
  size(1920, 1080);
  colorMode(HSB);
  frameRate(fps);

  //grid size relative to canvase
  rows = height / gridsize;
  cols = width / gridsize;

  //Set the game for the first run.
  resetGame();
}

void resetGame() {
  playing = false;
  // Setup initial flower placements
  flowers = new Flower[cols][rows];
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      flowers[x][y] = new Flower(x, y, false);
    }
  }
}

void draw() {
  if (fps < 1) {
    fps = 1;
  }

  frameRate(fps);
  background(127);

  // the grid of cells to be drawn
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y< rows; y++) {
      if (playing) {
        flowers[x][y].update();
      }
      flowers[x][y].show();
    }
  }
  // Draw tickrate
  fill(color(255, 255, 255));
  text("Turn Rate |" + fps, 0, 10);
}

boolean inBounds(int x, int y) {
  if ( x > -1 & x < cols) {
    if (y > -1 & y < rows) {
      return true;
    }
  }
  return false;
}

// Calls when the mouse is moved while the button is clicked
void mouseDragged() {
  if (!playing) {
    // Get Mouse Co-ords
    mousePos.x = mouseX;
    mousePos.y = mouseY;

    // Convert them to a grid co-ord
    int x = round(mousePos.x/gridsize);
    int y = round(mousePos.y/gridsize);
    
    flowers[x][y].setAlive(true);

    int[] xs = {x, x, x, x-1, x+1};
    int[] ys = {y, y+1, y-1, y, y};
  }
}

void keyPressed() {
  if (key == 'q' | key == 'Q') {
    fps++;
  }
  if (key == 'a' | key == 'A') {
    fps--;
  }
  if (key == 's'  | key == 'S') {
    playing = true;
  }
  if (key == 'p' | key == 'P') {
    playing = false;
  }
  if (key == 'e' | key == 'E') {
    resetGame();
  }
}
