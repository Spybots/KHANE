/*
 * Este archivo contiene la implementación del microjuego de discos, donde se suman
 * vectores bajo cierto campo finito.
 *
 * Autor: Iván A. Moreno Soto.
 * Última modificación: 02/Mayo/2017.
 */

private final int NUM_DIGITOS_DISCOS = 8;
private final int NUM_EXITOS_PARA_TERMINAR = 3;
private final int PUNTUACION_EXITO = 200;
private final int PENALIZACION_FALLO = -100;

/**
 *
 */
class Discos extends Microjuego {
    int modulo, exitos;
    Numero sumandoUno;
    Numero sumandoDos;
    Numero suma;
    
    Discos()
    {
        int digitos[];
        
        this.ID = 4;
        this.fallos = 0;
        this.exitos = 0;
        this.nombre = "Discos";
        this.termino = false;
        this.fallo = false;
        this.puntaje = 0.0;
        
        this.modulo = (int)(random(5));
        
        // Genera al azar el primer vector.
        digitos = new int[NUM_DIGITOS_DISCOS];
        for (int d = 0; d < NUM_DIGITOS_DISCOS; d++) {
            digitos[d] = (int)(random(modulo));
        }
        
        this.sumandoUno = new Numero(this.modulo, digitos);
    }
    
    boolean obtenerFallo()
    {
        return this.fallo;
    }
    
    boolean obtenerTermino()
    {   
        if (this.exitos == NUM_EXITOS_PARA_TERMINAR) {
            this.termino = true;
        } else {
            this.termino = false;
        }
        
        return this.termino;
    }
    
    void calcularPuntaje()
    {
        this.puntaje = (PUNTUACION_EXITO * this.exitos) - (PENALIZACION_FALLO * this.fallos);
    }
    
    void actualizar()
    {
        
    }
}