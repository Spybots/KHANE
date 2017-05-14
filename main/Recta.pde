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

    void dibujar(){
        line(punto1.obtenerX(), punto1.obtenerY(), punto2.obtenerX(), punto2.obtenerY());
    }
}
