/*
void setup()
{
    size(1000,1000);
}


void draw()
{   
    dibujarMaletin();  
}
*/
void dibujarMaletin()
{
    rect(width/8, height/8.75, width/1.25, height/1.8);
    
    line(width/8, height/8.75, width/15, width/12);
    line(width/8, height/8.75 + width/1.80, width/15, width/12 +width/1.80);
    line(width/8 +height/1.25, height/8.75, width/15 +height/1.25, width/12);
    
    line(width/15, width/12, width/15, width/12 +width/1.80);
    line(width/15, width/12, width/15 +height/1.25, width/12);
    
    line(width/1.95, height/8.75,width/1.95, height/1.50);
    line(width/8.05, width/2.5, width/8.05 +height/1.25, width/2.5);   
}
