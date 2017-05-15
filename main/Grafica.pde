/*
 * Este archivo contiene la clase Grafica, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */
 
class Grafica{
    private Set<Punto> conjPuntos;
    private Set<Recta> conjRectas;
    
    Grafica(Set<Punto> conjPuntos, Set<Recta> conjRectas){
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
