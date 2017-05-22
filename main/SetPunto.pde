import java.util.*;

/*
 * Este archivo contiene la clase Punto, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */

class SetPunto extends HashSet{

    /**
    * @brief Sobrecarga de la igualdad para revisar si dos conjuntos de puntos son iguales.
    * @param conjPuntos El otro conjunto de puntos con el que se quiera comparar si son iguales.
    * @return true si ambos conjuntos contienen los mismos elementos, false en otro caso.
    */
  public boolean equals(HashSet conjPuntos){
        //si las capacidades son diferentes, no pueden ser los mismos conjuntos
        if(this.size() != conjPuntos.size()){
            return false;
        }

        Iterator<Punto> iterador1 = this.iterator();
        Iterator<Punto> iterador2 = conjPuntos.iterator();
        Punto punto1 = null;
        boolean mismoPunto = false;

        while(iterador1.hasNext()){
            punto1 = iterador1.next(); //se guarda el punto del primer conjunto para comparar con todo el segundo conjunto
            mismoPunto = false; //se asume que el punto no existe en el segundo conjunto
            //mientras no se encuentre un punto igual y el segundo conjunto tenga elementos, se busca un punto igual
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

    /**
    * @brief Sobrecarga del metodo contains para revisar si un conjunto contiene a un punto en particular.
    * @param punto El punto que se quiere saber si esta contenido en el conjunto.
    * @return true si el conjunto contiene al punto, false en otro caso.
    */
    public boolean contains(Punto punto){
        Iterator<Punto> iterador = this.iterator();
        while(iterador.hasNext()){
            if(iterador.next().equals(punto)){
                return true;
            }
        }

        return false;
    }

    /**
    * @brief Sobrecarga del metodo add para agregar un elemento al conjunto.
    * @param punto El punto que se quiere agregar al conjunto.
    * @return true si el conjunto no contenia anteriormente al elemento y lo agrego, false en otro caso.
    */
    public boolean add(Punto punto){
        if(!this.contains(punto)){
            return super.add(punto);
        }

        return false;
    }

    /**
    * @brief Metodo para dibujar todos los puntos contenidos en el conjunto.
    */
    public void dibujar(){
        Iterator<Punto> iterador = this.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar();
        }
    }
    
    /**
    * @brief Metodo para dibujar todos los puntos contenidos en el conjunto.
    * @param colorPuntos Color con el que se quiere pintar todos los puntos del conjunto.
    */
    public void dibujar(color colorPuntos){
        Iterator<Punto> iterador = this.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar(colorPuntos);
        }
    }
}