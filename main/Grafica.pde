/*
 * Este archivo contiene la clase Grafica, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */
 
class Grafica{
    private Punto[] punto;
    private Recta[] recta;    
    private int nPuntos;
    private int nRectas;
    
    Grafica(Punto[] punto, Recta[] recta, int nPuntos, int nRectas){
        this.punto = punto;
        this.recta = recta;
        this.nPuntos = nPuntos;
        this.nRectas = nRectas;
    }

    void dibujar(){
        for(int i = 0; i < nRectas; ++i){
            recta[i].dibujar();
        }

        for(int i = 0; i < nPuntos; ++i){
            punto[i].dibujar();
        }
    }
}
