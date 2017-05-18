//import ddf.minim.*;
//Minim minim;

//import Microjuego;
//Three sounds for different situations
//AudioSample bad;
//AudioSample good;
//AudioSample tada;
//***********************************************************************************
/*
Cipher instancia;
//PFont font;

void setup()
{
    instancia = new Cipher();
    size(1000, 600);
    background(#2DB8ED);
    //instancia.font = createFont("times", 16, true);
    textFont(instancia.font, 60);
    
    //minim = new Minim(this);
    //assign the sounds
    //good = minim.loadSample("good.wav");
    //bad = minim.loadSample("bad.wav");
    //tada = minim.loadSample("tada.wav");
    instancia.px = width / 2;
    instancia.py = 400;
    //reset is a function defined below
    instancia.reset();
}

void draw()
{
    instancia.actualizar();
}

void keyPressed()
{
    instancia.teclaPresionada(key);
}
*/
class Cipher extends Microjuego
{
    //modify this for change the max time
    int tiempoInicial = 100;
    
    int conta;
    int tiempo;
    int puntaje;
    int nivel;
    PFont font;
    
    int fallos;
    boolean fallo;
    boolean termino;
    
    boolean run;
    
    char[] letras = {'x', 'y', 'z','a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z','a', 'b', 'c'};
    
    //initialize the letraActual
    char letraActual;
    //position and size of the letter (those change respect the nivel)
    float px;
    float py;
    float tamanioLetra;
    
    Cipher()
    {
        //modify this for change the max time
        tiempoInicial = 100;
        
        conta = 0;
        tiempo = tiempoInicial;
        puntaje = 0;
        nivel = 1;
        font = createFont("times", 16, true);
        
        fallos = 0;
        fallo = false;
        termino = false;
        
        run = false;
     
        //initialize the letraActual
        letraActual = ' ';
        //position and size of the letter (those change respect the nivel)
  
        tamanioLetra = 250; 
    }
    
    boolean obtenerFallo()
    {
        return fallo;
    }
    boolean obtenerTermino()
    {
        return termino;
    }
    void calcularPuntaje()
    {
    }
    
    void procesarClick()
    {
    }
    
    void actualizar(){
        if (this.run == true) {
            this.conta += 1;
            fill(#2DB8ED);
            rect(0, 0, width, height);
          
            fill(0);
            //this is for do slow clock
            if (this.conta == 10) {
                this.tiempo--;
                this.conta = 0;
            }
            
            textFont(this.font, this.tamanioLetra);
            text(this.letraActual, this.px, this.py);
            
            //if clock is zero, show the score
            if ( this.tiempo <= 0) {
                this.tiempo = 0;
                this.run = false;
                this.termino = true;
                this.resultados();
              }
        }else{
            this.reset();
        }      
        //those lines are for draw the box of time, puntaje, nivel
        textFont(this.font, 60);
        fill(#B6D315);
        rect(20, 20, 300, 60);
        fill(0);
        text("Time : " + str(this.tiempo), 170, 75);
        
        fill(#B6D315);
        strokeWeight(5);
        rect(350, 20, 300, 60);
        fill(0);
        text("puntaje : " + str(this.puntaje), 500, 75);
        
        fill(#B6D315);
        strokeWeight(5);
        rect(680, 20, 300, 60);
        fill(0);
        text("nivel : " + str(this.nivel), 830, 75);
    }
    
    void reset()
    {
        fill(#2DB8ED);
        rect(0, 0, width, height);
          
        PImage img = loadImage("1.jpg");
        image(img, 400, 150, 374, 323);
        
        stroke(0);
        strokeWeight(5);
        fill(#4CE5D0);
        rect(30, 150, 260, 323);
        textFont(font, 20);
        textAlign(CENTER);
        fill(255, 0, 0);
        text(" Typing game", 140, 180);
        textFont(font, 16);
        textAlign(LEFT);
        fill(0);
        text("GET READY YOUR FINGERS !!!\n         GOTTA TYPE FAST ", 47, 210);
        text("These are the commands:\n * 0 = reset \n * 1, 2, 3 = set nivel \n * space = start the game\n * esc = exit", 47, 310);
        
        textAlign(CENTER);
        
        textFont(font, 60);
        fill(#B6D315);
        rect(20, 20, 300, 60);
        fill(0);
        text("Time : " + str(tiempo), 170, 75);
        
        fill(#B6D315);
        strokeWeight(5);
        rect(350, 20, 300, 60);
        fill(0);
        text("puntaje : " + str(puntaje), 500, 75);
        
        fill(#B6D315);
        strokeWeight(5);
        rect(680, 20, 300, 60);
        fill(0);
        text("nivel : " + str(nivel), 830, 75);
     }
     
     void teclaPresionada()
     {
         switch (key) {
         case ' ':
              if (run == false) {
                  letraActual = letraAzar();
                  run = true;
              }
              break;
         case '1':
              if (run == false){
                  nivel = 1;
              }
              break;
         case '2':
              if (run == false){
                  nivel = 2;
              }
              break;
         case '3':
                if ( run == false){
                    nivel = 3;
                }
                break;
         case '0':
              letraActual = ' ';
              tiempo = tiempoInicial;
              run = false;
              fallo = false;
              termino = false;
              fallos = 0;
              puntaje = 0;
              nivel = 1;
              px = width / 2;
              py = 400;
              tamanioLetra = 250;
              reset();
              break;
        }    
        
        
        if (run == true && key != ' '){
            if (key == letraActual) {
                //if the keypress is good, play a sound
                puntaje++;
                //good.trigger();
            } else {
                //if the keypress is bad, play a sound
                puntaje--;
                ++fallos;
                if(fallos > 3){
                    fallo = true;
                    //reset();
                }
                background(#db1313);//efecto de fallo
                //bad.trigger();
            }
        
            //generate a letraAzar (is defined below)
            letraActual = letraAzar();
            //select the nivel
            if (nivel == 1) {
                px = width / 2;
                py = 400;
                tamanioLetra = 250;
            }
            else if (nivel == 2) {
                tamanioLetra = 250;
                px = random(0, width - 70);
                py = random(tamanioLetra, height - tamanioLetra);
            } else if (nivel == 3){
                tamanioLetra = random(50, 250);
                px = random(0, width - 70);
                py = random(tamanioLetra, height - tamanioLetra);
            }   
         }  
      }
      
      
      //function for generate a letraAzar
      char letraAzar()
      {
        return letras[int(random(3, 29))];
      }
      
      //function for set the initial configuration
      
      
      //function for print the score and play a tada
      void resultados()
      {
        fill(#2DB8ED);
        rect(0, 0, width, height);
        textFont(font, 170);
        textAlign(CENTER);
        fill(255, 0, 0);
        text(" Tu puntaje: \n" + str(puntaje), width / 2, 250);
        //tada.trigger();
      }
}
