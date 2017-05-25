/*
 * Este archivo contiene la clase Recta, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */

class Recta{
    
    /*****************************************************/
    
    private final Punto punto1;
    private final Punto punto2;
    private color rColor;
    
    /*****************************************************/

    /**
    * @brief Constructor que recibe dos puntos y crea una linea entre los dos puntos.
    * @param punto1 Uno de los dos puntos necesarios para crear una recta.
    * @param punto2 Uno de los dos puntos necesarios para crear una recta.
    */
    public Recta(Punto punto1, Punto punto2)
    {
        this.punto1 = punto1;
        this.punto2 = punto2;
        this.rColor = color(0, 0, 0);
    }
    
    /*****************************************************/

    /**
    * @brief Constructor que recibe dos puntos y crea una linea entre los dos puntos. Ademas el color de la recta.
    * @param punto1 Uno de los dos puntos necesarios para crear una recta.
    * @param punto2 Uno de los dos puntos necesarios para crear una recta.
    * @param rColor Color para la recta.
    */
  public Recta(Punto punto1, Punto punto2, color rColor)
  {
        this.punto1 = punto1;
        this.punto2 = punto2;
    this.rColor = rColor;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para obtener el primer punto. Que sea el primero no significa mucho, solo que se llama punto1.
    * @return El punto1 de la recta.
    */
    public Punto obtenerPunto1()
    {
        return this.punto1;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para obtener el segundo punto. Que sea el segundo no significa mucho, solo que se llama punto2.
    * @return El punto2 de la recta.
    */
    public Punto obtenerPunto2()
    {
        return this.punto2;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para obtener el color de la recta.
    * @return El color de la recta.
    */
    public color obtenerColor()
    {
        return this.rColor;
    }
    
    /*****************************************************/

    /**
    * @brief Sobrecarga de la igualdad para revisar si dos rectas son iguales.
    * @param recta La recta con la que se quiere comparar la igualdad.
    * @return true si ambas rectas tienen los mismos puntos, sin importar su orden.
    */
    public boolean equals(Recta recta)
    {
        return (this.punto1.equals(recta.punto1) &&
                this.punto2.equals(recta.punto2))||
               (this.punto1.equals(recta.punto2) &&
                this.punto2.equals(recta.punto1));
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para dibujar la recta en su posicion y con su color.
    */
    public void dibujar()
    {
    stroke(this.rColor);
        line(punto1.obtenerX(), punto1.obtenerY(), punto2.obtenerX(), punto2.obtenerY());
    }
    
    /*****************************************************/
    
    /**
    * @brief Metodo para dibujar la recta en su posicion y con su color.
    * @param rColor Color con el que se quiere pintar la recta.
    */
    public void dibujar(color rColor)
    {
    stroke(rColor);
        line(punto1.obtenerX(), punto1.obtenerY(), punto2.obtenerX(), punto2.obtenerY());
    }
}