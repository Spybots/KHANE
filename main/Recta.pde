/*
 * Este archivo contiene la clase Recta, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */
 
class Recta{
    private Punto punto1;
    private Punto punto2;
  
    Recta(Punto punto1, Punto punto2){
        this.punto1 = punto1;
        this.punto2 = punto2;
    }
    
    Punto obtenerPunto1(){
        return this.punto1; 
    }
    
     Punto obtenerPunto2(){
        return this.punto2; 
    }

	boolean equals(Recta recta){
        return (this.punto1.equals(recta.punto1) &&
                this.punto2.equals(recta.punto2))||
               (this.punto1.equals(recta.punto2) &&
                this.punto2.equals(recta.punto1));
    }

    void dibujar(){
        line(punto1.obtenerX(), punto1.obtenerY(), punto2.obtenerX(), punto2.obtenerY());
    }
}
