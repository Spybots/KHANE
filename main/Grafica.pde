/*
 * Este archivo contiene la clase Grafica, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */
 
class Grafica{
    private SetPunto conjPuntos;
    private SetRecta conjRectas;
    
    Grafica(SetPunto conjPuntos, SetRecta conjRectas){
        this.conjPuntos = conjPuntos;
        this.conjRectas = conjRectas;
    }

    void dibujar(){
        Iterator<Recta> iteradorRecta = this.conjRectas.iterator();
        while(iteradorRecta.hasNext()){
           iteradorRecta.next().dibujar(); 
        }

	    Iterator<Punto> iteradorPunto = this.conjPuntos.iterator();
        while(iteradorPunto.hasNext()){
           iteradorPunto.next().dibujar(); 
        }
    }

	void dibujarRectas(){
        Iterator<Recta> iteradorRecta = this.conjRectas.iterator();
        while(iteradorRecta.hasNext()){
           iteradorRecta.next().dibujar(); 
        }
    }

    void dibujarPuntos(){
        Iterator<Punto> iteradorPunto = this.conjPuntos.iterator();
        while(iteradorPunto.hasNext()){
           iteradorPunto.next().dibujar(); 
        }
    }
}
