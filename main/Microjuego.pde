/*
 * Este archivo contiene la clase padre de todos los microjuegos de KHANE.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 15/Mayo/2017.
 */

/*****************************************************/

/**
 * Clase padre de todo microjuego que forma parte de KHANE. Define métodos abstractos para mantener
 * una estandarización en la implementación de los microjuegos.
 */
abstract class Microjuego {
    // Atributos de la clase.
    int ID, fallos;
    String nombre;
    boolean termino, fallo;
    int puntaje;
    
    /*****************************************************/
    
    /**
     * @brief Actualiza el estado actual del microjuego que está jugando el usuario o del
     * maletín para seleccionar el nivel.
     */
    double obtenerPuntaje()
    {
        return this.puntaje;
    }
    
    /*****************************************************/
    
    /**
     * @brief Devuelve el número de identificación del microjuego.
     * @return ID del microjuego.
     */
    int obtenerID()
    {
        return this.ID;
    }
    
    /*****************************************************/
    
    /**
     * @brief Devuelve el nombre del microjuego.
     * @return Nombre del microjuego.
     */
    String obtenerNombre()
    {
        return this.nombre;
    }
    
    /*****************************************************/
    
    /**
     * @brief Devuelve si el usuario ha fallado en el microjuego desde la última vez que se
     * mandó a llamar esta función.
     * @return Verdadero si hay un fallo, falso de otro modo.
     */
    abstract boolean obtenerFallo();
    
    /*****************************************************/
    
    /**
     * @brief Devuelve si el microjuego ha terminado.
     * @return Verdadero si el microjuego terminó, falso de otro modo.
     */
    abstract boolean obtenerTermino();
    
    /*****************************************************/
    
    /**
     * @brief Calcula el puntaje actual del microjuego.
     */
    abstract void calcularPuntaje();
    
    /*****************************************************/
    
    /**
     * @brief Actualiza el estado actual del microjuego que está jugando el usuario o del
     * maletín para seleccionar el nivel.
     */
    abstract void actualizar();
    
    /**
     * @brief Modifica el estado actual del microjuego cuando el usaurio presiona una tecla del teclado.
     */
    abstract void procesarTeclas();
    
    /*****************************************************/
    
    /**
     * @brief Modifica el estado actual del microjuego cuando el usuario hace click en pantalla.
     */
    abstract void procesarClick();
    
    /*****************************************************/
} // Fin de la clase Microjuego.

/*****************************************************/