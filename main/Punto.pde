import java.util.*;

/*
 * Este archivo contiene la clase Punto, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */
 
class Punto{
    private float x;
    private float y;
    private float width;
    private float height;
    private Set<Punto> conexiones;
  
    Punto(float x, float y){
        this.x = x;
        this.y = y;
        this.width = 10;
        this.height = 10;
        this.conexiones = new HashSet<Punto>();
    }

    float obtenerX(){
        return this.x;
    }

    float obtenerY(){
        return this.y;
    }
    
    void conectarPunto(Punto punto){
        this.conexiones.add(punto);
    }

    void dibujar(){
        ellipse(this.x, this.y, this.width, this.height);
    }
}