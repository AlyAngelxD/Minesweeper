

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined
boolean isLost = false;
boolean isWon = false;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int row = 0; row < NUM_ROWS; row++)
    {
        for (int col = 0; col < NUM_COLS; col++)
        {
            buttons[row][col] = new MSButton(row,col);
        }
    }    
    setBombs();
}
public void setBombs()
{
    for (int i = 0; i < 20; i++)
    {
        int ranRow = (int)(Math.random()*20);
        int ranCol = (int)(Math.random()*20);
        if (!bombs.contains(buttons[ranRow][ranCol]))
        {
            bombs.add(buttons[ranRow][ranCol]);
        }   
    } 
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public void showBombs()
{
    for (int r = 0; r < NUM_ROWS; r++)
    {
        for (int c = 0; c < NUM_COLS; c++)
        {
            if (bombs.contains(buttons[r][c]))
            {
                buttons[r][c].setLabel("X");
            }
        }
    }
}
public boolean isWon()
{
    for (int r = 0; r < NUM_ROWS; r++)
    {
        for (int c = 0; c < NUM_COLS; c++)
        {
            if (!buttons[r][c].isClicked() && !bombs.contains(buttons[r][c]))
            {
                return false;
            }
            if (buttons[r][c].isClicked() && bombs.contains(buttons[r][c]))
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    System.out.println("You lose!"); //Change to text later.
    showBombs();
    isLost = true;
}
public void displayWinningMessage()
{
    System.out.println("You win!"); //Change to text later.
    showBombs();
    isWon = true;
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed() 
    {
        clicked = true;
        if (keyPressed == true)
        {
            if (marked == true)
                marked = false;
            else
                clicked = false;
        }
        else if (bombs.contains(buttons[r][c])) 
        {
            displayLosingMessage();
            isLost = true;
        }
        else if (countBombs(r,c) >= 1)
        {
            setLabel(Integer.toString(countBombs(r,c)));
        }
        else
        {
            if (isValid(r-1,c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();
            if (isValid(r,c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();
            if (isValid(r,c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();
            if (isValid(r+1,c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);   
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
        if (isLost == true)
            text("You lose!", 200, 200);
        if (isWon == true)
            text("You win!", 200, 200);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs = numBombs + 1;
        }
        if (isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs = numBombs + 1;
        }
        if (isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs = numBombs + 1;
        }
        if (isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs = numBombs + 1;
        }
        if (isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs = numBombs + 1;
        }
        if (isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs = numBombs + 1;
        }
        if (isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs = numBombs + 1;
        }
        if (isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs = numBombs + 1;
        }
        return numBombs;
    }
}



