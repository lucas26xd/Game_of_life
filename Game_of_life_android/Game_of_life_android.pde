/*
GAME OF LIFE CONWAY
 - Draw the shape by left clicking
 - Play/Pause with right mouse button
 */
int grid[][];
int resolution = 100;
boolean play = false;

void setup() {
  fullScreen();
  stroke(200);
  frameRate(10);

  grid = new int[width/resolution][height/resolution];

  //If you don't want to start randomly, comment the line below
  //randomInit();
}

void randomInit() {
  play = true;
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      grid[i][j] = int(random(2));
    }
  }
}

int touchInit, touchEnd;

void touchStarted() {
  touchInit = millis();
}

void touchEnded() {
  touchEnd = millis();
  int i = int(mouseX / resolution), j = int(mouseY / resolution);
  if (i >= grid.length) i--;
  if (j >= grid[0].length) j--;
  if (touchEnd - touchInit < 500) // Short press
    grid[i][j] = grid[i][j] == 0 ? 1 : 0;
  else
    play = !play;
}

void draw() {
  displayGrid();
  if (play)
    nextGeneration();
}

void displayGrid() {
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      fill(grid[i][j] * (play ? 255 : 180));
      rect(resolution * i, resolution * j, resolution, resolution);
    }
  }
}

void nextGeneration() { // Rules of the game
  int next[][] = grid;
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      int n = nNeighbors(i, j);
      int x = grid[i][j];
      if (isAlive(x) && (n < 2 || n > 3))
        next[i][j] = 0;
      else if (isDead(x) && n == 3)
        next[i][j] = 1;
    }
  }
  grid = next;
}

int nNeighbors(int x, int y) {
  int n = 0;
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      if ((i != 0 || j != 0) && isInBounds(x, i, y, j))
        n += grid[x + i][y + j];
    }
  }
  return n;
}

boolean isInBounds(int x, int i, int y, int j) {
  return x + i >= 0 && x + i < grid.length && y + j >= 0 && y + j < grid[x].length;
}

boolean isAlive(int x) {
  return x == 1;
}

boolean isDead(int x) {
  return x == 0;
}
