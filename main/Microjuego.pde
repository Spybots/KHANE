abstract class Microjuego {
    int ID;
    String nombre;
    boolean termino;
    boolean fallo;
    double puntaje;
    
    double obtenerPuntaje()
    {
        return this.puntaje;
    }
    
    int obtenerID()
    {
        return this.ID;
    }
    
    String obtenerNombre()
    {
        return this.nombre;
    }
    
    abstract boolean obtenerFallo();
    abstract boolean obtenerTermino();
    abstract void calcularPuntaje();
    abstract void actualizar();
    abstract void procesarClick();
}