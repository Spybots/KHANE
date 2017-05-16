import java.util.*;

/*
 * Este archivo contiene la clase Punto, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */
 
class SetRecta extends HashSet{

	boolean equals(HashSet conjRectas){
        //si los conjuntos tienen distintas capacidades, son distintos
        if(this.size() != conjRectas.size()){
            return false;
        }

        Iterator<Recta> iterador1 = this.iterator();
        Iterator<Recta> iterador2 = conjRectas.iterator();
        Recta recta1 = null;
        boolean mismaRecta = false;

        while(iterador1.hasNext()){
            recta1 = iterador1.next();
            mismaRecta = false;
            while(!mismaRecta && iterador2.hasNext()){
                //si se encuentra una recta que es igual, se pasa a la siguiente iteracion
                if(recta1.equals(iterador2.next())){
                    mismaRecta = true;
                }
            }
            //si despues de revisar todos los elementos del segundo conjunto, no hay ninguno igual al primero, entonces no son iguales
            if(!mismaRecta){
                return false;
            }
        }
        //si todos los elementos del primer conjunto estan en el segundo, entonces los conjuntos son iguales
        return true;
    }

    boolean contains(Recta recta){
        Iterator<Recta> iterador = this.iterator();
        while(iterador.hasNext()){
            if(iterador.next().equals(recta)){
                return true;
            }
        }

        return false;
    }

    boolean add(Recta recta){
        if(!this.contains(recta)){
            return super.add(recta);
        }

        return false;
    }

    void dibujar(){
        Iterator<Recta> iterador = this.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar();
        }
    }
}
