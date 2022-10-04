## GAME OF LIFE CONWAY
# - Draw the shape by left clicking
# - Play/Pause with right mouse button

grid = []
resolution = 20
play = False

def setup():
    size(600, 400)
    stroke(200)
    frameRate(10)
    
    for i in range(width//resolution):
        grid.append([0 for i in range(height//resolution)])
    
    #If you don't want to start randomly, comment the line below
    #random_init()

def random_init():
    global play, grid
    play = True
    for i in range(len(grid)):
        for j in range(len(grid[i])):
            grid[i][j] = int(random(2))


def mousePressed():
    global play, grid
    i = mouseX // resolution
    j = mouseY // resolution
    if mouseButton == LEFT:
        grid[i][j] = 0 if grid[i][j] else 1
    elif mouseButton == RIGHT:
        play = not play

def draw():
    display_grid()
    if play:
        grid = next_generation()

def display_grid():
    for i in range(len(grid)):
        for j in range(len(grid[i])):
            fill(grid[i][j] * (255 if play else 180))
            rect(resolution * i, resolution * j, resolution, resolution)

def next_generation(): # Rules of the game
    next = grid
    for i in range(len(grid)):
        for j in range(len(grid[i])):
            n = n_neighbors(i, j)
            if grid[i][j] and (n < 2 or n > 3):
                next[i][j] = 0
            elif not grid[i][j] and n == 3:
                next[i][j] = 1
    return next

def n_neighbors(x, y):
    n = 0
    for i in range(-1, 2):
        for j in range(-1, 2):
            if (i != 0 or j != 0) and isInBounds(x, i, y, j):
                n += grid[x + i][y + j]
    return n

def isInBounds(x, i, y, j):
    return x + i >= 0 and x + i < len(grid) and y + j >= 0 and y + j < len(grid[x])
