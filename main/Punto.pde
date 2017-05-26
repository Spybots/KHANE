import java.util.*;

/*
 * Este archivo contiene la clase Punto, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 25/Mayo/2017
 */

class Punto{
    
    /*****************************************************/
    
    private float x;
    private float y;
    private float width;
    private float height;
    private SetPunto conexiones;
    private color pColor;
    
    /*****************************************************/

    /**
    * @brief Constructor que recibe la posicion en x y y del punto y crea un punto con color(0, 0, 0).
    * @param x Posicion en x.
    * @param y Posicion en y.
    */
    public Punto(float x, float y)
    {
        this.x = x;
        this.y = y;
        this.width = 10;
        this.height = 10;
        this.conexiones = new SetPunto();
        this.pColor = color(0, 0, 0);
    }
    
    /*****************************************************/

  /**
    * @brief Constructor que recibe la posicion en x y y del punto y el color que se quiere.
    * @param x Posicion en x.
    * @param y Posicion en y.
    * @param pColor Color del punto.
    */
    public Punto(float x, float y, color pColor)
    {
        this.x = x;
        this.y = y;
        this.width = 10;
        this.height = 10;
        this.conexiones = new SetPunto();
    this.pColor = pColor;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para obtener la posicion en x de un punto.
    * @return La posicion en x de un punto.
    */
    public float obtenerX()
    {
        return this.x;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para obtener la posicion en y de un punto.
    * @return La posicion en y de un punto.
    */
    public float obtenerY()
    {
        return this.y;
    }
    
    /*****************************************************/

  /**
    * @brief Metodo para obtener el color de un punto.
    * @return El color del punto.
    */
    public color obtenerColor()
    {
    return this.pColor;
    }

    /**
    * @brief Metodo para conectar el punto a algun otro.
    * @param punto El punto al que se quiere conectar.
    */
    public void conectarPunto(Punto punto){
        this.conexiones.add(punto);
    }
    
    /*****************************************************/

    /**
    * @brief Sobrecarga de la igualdad para revisar si dos puntos son iguales.
    * @param punto El punto al que se quiere comparar la igualdad.
    * @return true si ambos puntos tienen las mismas coordenadas, false en cualquier otro caso.
    */
    public boolean equals(Punto punto)
    {
        return this.x == punto.x && this.y == punto.y;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para dibujar el punto en su posicion y con su color.
    */
    public void dibujar()
    {
        fill(this.pColor);
        ellipse(this.x, this.y, this.width, this.height);
    }
    
    /*****************************************************/
    
    /**
    * @brief Metodo para dibujar el punto en su posicion y con su color.
    * @param pColor Color con el que se quiera pintar al punto.
    */
    public void dibujar(color pColor)
    {
        fill(pColor);
        ellipse(this.x, this.y, this.width, this.height);
    }
}