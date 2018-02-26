

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

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
            System.out.println(ranRow+", "+ranCol); //for testing
        }   
    } 
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    System.out.println("You lose!"); //Change to text later.
}
public void displayWinningMessage()
{
    System.out.println("You win!"); //Change to text later.
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
    
    public void mousePressed () 
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
        }
        else if (countBombs(r,c) > 0)
        {
            text(countBombs(r,c), 1, 1);
        }
        else
        {
            mousePressed();
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
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r >= 0 && r <= 20 && c >= 0 && c <= 20)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (buttons[row-1][col-1].isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs = numBombs + 1;
        }
        else if (buttons[row-1][col].isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs = numBombs + 1;
        }
        else if (buttons[row-1][col+1].isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs = numBombs + 1;
        }
        else if (buttons[row][col-1].isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs = numBombs + 1;
        }
        else if (buttons[row][col+1].isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs = numBombs + 1;
        }
        else if (buttons[row+1][col-1].isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs = numBombs + 1;
        }
        else if (buttons[row+1][col].isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs = numBombs + 1;
        }
        else if (buttons[row+1][col+1].isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs = numBombs + 1;
        }
        else 
        {
            System.out.println("NULL");
        }
        return numBombs;
    }
}



