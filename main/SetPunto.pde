import java.util.*;

/*
 * Este archivo contiene la clase Punto, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */
 
class SetPunto extends HashSet{

	boolean equals(HashSet conjPuntos){
        if(this.size() != conjPuntos.size()){
            return false;
        }

        Iterator<Punto> iterador1 = this.iterator();
        Iterator<Punto> iterador2 = conjPuntos.iterator();
        Punto punto1 = null;
        boolean mismoPunto = false;

        while(iterador1.hasNext()){
            punto1 = iterador1.next();
            mismoPunto = false;
            while(!mismoPunto && iterador2.hasNext()){
                //si se encuentra un punto que es igual, se pasa a la siguiente iteracion
                if(punto1.equals(iterador2.next())){
                    mismoPunto = true;
                }
            }
            //si despues de revisar todos los elementos del segundo conjunto, no hay ninguno igual al primero, entonces no son iguales
            if(!mismoPunto){
                return false;
            }
        }
        //si todos los elementos del primer conjunto estan en el segundo, entonces los conjuntos son iguales
        return true;
    }

    boolean contains(Punto punto){
        Iterator<Punto> iterador = this.iterator();
        while(iterador.hasNext()){
            if(iterador.next().equals(punto)){
                return true;
            }
        }

        return false;
    }

    boolean add(Punto punto){
        if(!this.contains(punto)){
            return super.add(punto);
        }

        return false;
    }

    void dibujar(){
        Iterator<Punto> iterador = this.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar();
        }
    }
}
