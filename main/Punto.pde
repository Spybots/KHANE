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
  
    Punto(float x, float y){
        this.x = x;
        this.y = y;
        this.width = 10;
        this.height = 10;
    }

    float obtenerX(){
        return this.x;
    }

    float obtenerY(){
        return this.y;
    }

    void dibujar(){
        ellipse(this.x, this.y, this.width, this.height);
    }
}
