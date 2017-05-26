/*
 * Este archivo contiene la implementación del microjuego del cipher,
 * donde se solicitan letras en funcion de letras mostradas.
 *
 * Autor: Urias Paramo Jordan Joel.
 * Última modificación: 25/Mayo/2017.
 */
//***********************************************************************************
class Cipher extends Microjuego
{
    int tiempoInicial = 100;
    
    int conta;
    int tiempo;
    //int puntaje;
    int nivel;
    PFont font;
    int letra;
    
    //int fallos;
    int modulo = (serial>50) ? 7 : 10;
    int recorrido=int( ((serial%modulo)+1) * pow(-1, serial%2));
    //boolean fallo;
    //boolean termino;
    
    boolean run;
    
    char[] letras = {'q', 'r', 's', 't', 'u', 'v', 'w','x', 'y', 'z','a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z','a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'};


    char letraActual;
    char letraMostrada;

    float px;
    float py;
    float tamanioLetra;
    
    Cipher()
    {
        tiempoInicial = 100;
        
        conta = 0;
        tiempo = tiempoInicial;
        puntaje = 0;
        nivel = 1;
        font = createFont("times", 60, true);
        
        ID = 1;
        fallos = 0;
        fallo = false;
        termino = false;
        
        run = false;
     
        letraActual = ' ';
        letraMostrada = ' ';
  
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
        puntaje = (puntaje - fallos) * nivel * 100;
    }
    
    void procesarClick()
    {
    }
    
    void actualizar(){
        if (this.run == true) {
            this.conta += 1;
            fill(0,0,0);
            rect(0, 0, width, height);
            
            fill(255, 0, 0);
            textFont(this.font, this.tamanioLetra);
            text(this.letraMostrada, this.px, this.py);
            //text(this.letraActual, this.px +50, this.py +50);
            
            if ( this.fallos > 2) {
                this.tiempo = 0;
                this.fallo = true;
                this.run = false;
                this.termino = false;
            }
            
            if (this.puntaje >= 5) {
                this.tiempo = 0;
                this.fallo = false;
                this.run = false;
                this.termino = true;
            }
        }else{
            if(termino)
                this.resultados();
            else
                this.reset();
        }      
        //cajas
        textFont(this.font, 60);
        fill(#B6D315);
        rect(20, 20, 300, 60);
        fill(0);
        text("Fallos : " + str(this.fallos), 170, 75);
        
        fill(#B6D315);
        strokeWeight(5);
        rect(350, 20, 300, 60);
        fill(0);
        text("Puntaje : " + str(puntaje), 500, 75);
        
        fill(#B6D315);
        strokeWeight(5);
        rect(680, 20, 300, 60);
        fill(0);
        text("Nivel : " + str(this.nivel), 830, 75);
    }
    
    void reset()
    {
        fill(0,0,0);
        rect(0, 0, width, height);
        
        stroke(0);
        strokeWeight(5);
        fill(#B6D315);
        rect(230, 150, 260, 323);
        textFont(font, 20);
        textAlign(CENTER);
        fill(255, 0, 0);
        text(" Juego de teclear", 340, 180);
        textFont(font, 16);
        textAlign(LEFT);
        fill(0);
        text("PREPARATE!!!", 247, 210);
        text("Comandos:\n * 0 = reset \n * 1, 2, 3 = Escojer nivel \n * space = Iniciar juego\n * TAB = Salida", 247, 310);
        
        textAlign(CENTER);
        
        //cajas 
        textFont(this.font, 60);
        fill(#B6D315);
        rect(20, 20, 300, 60);
        fill(0,0,0);
        text("Fallos : " + str(this.fallos), 170, 75);
        
        fill(#B6D315);
        strokeWeight(5);
        rect(350, 20, 300, 60);
        fill(0);
        text("Puntaje : " + str(puntaje), 500, 75);
        
        fill(#B6D315);
        strokeWeight(5);
        rect(680, 20, 300, 60);
        fill(0);
        text("Nivel : " + str(this.nivel), 830, 75);
     }
     
     void procesarTeclas()
     {
         switch (key) {
         case ' ':
              if (run == false) {
                  letraActual = ' ';
                  letraMostrada = ' ';
                  tiempo = tiempoInicial;
                  run = false;
                  fallo = false;
                  termino = false;
                  fallos = 0;
                  puntaje = 0;
                  px = width / 2;
                  py = 400;
                  tamanioLetra = 170;
                  letra = letraAzar();
                  letraActual = letras[letra];
                  letraMostrada = letras[letra+recorrido];
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
              letraMostrada = ' ';
              tiempo = tiempoInicial;
              run = false;
              fallo = false;
              termino = false;
              fallos = 0;
              puntaje = 0;
              nivel = 1;
              px = width / 2;
              py = 400;
              tamanioLetra = 170;
              reset();
              break;
        }    
        
        
        if (run == true && key != ' '){
            if (key == letraActual) {
                puntaje++;
            } else {
                puntaje--;
                ++fallos;
                
                background(#db1313);
            }
        
            letra = letraAzar();
            letraActual = letras[letra];
            letraMostrada = letras[letra+recorrido];
            
            if (nivel == 1) {
                px = width / 2;
                py = 400;
                tamanioLetra = 170;
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
      
      int letraAzar()
      {
        return int(random(10, 36));
      }
      
      void resultados()
      {
        fill(0,0,0);
        rect(0, 0, width, height);
        textFont(font, 170);
        textAlign(CENTER);
        fill(255, 0, 0);
        text(" Tu puntaje: \n" + str(puntaje), width / 2, 250);
      }
}