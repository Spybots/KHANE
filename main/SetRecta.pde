import java.util.*;

/*
 * Este archivo contiene la clase Punto, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */

class SetRecta extends HashSet{

    /*****************************************************/
    
    /**
    * @brief Sobrecarga de la igualdad para revisar si dos conjuntos de rectas son iguales.
    * @param conjRectas El otro conjunto de rectas con el que se quiera comparar si son iguales.
    * @return true si ambos conjuntos contienen los mismos elementos, false en otro caso.
    */
    public boolean equals(HashSet conjRectas){
        //si las capacidades son diferentes, no pueden ser los mismos conjuntos
        if(this.size() != conjRectas.size()){
            return false;
        }

        Iterator<Recta> iterador1 = this.iterator();
        Iterator<Recta> iterador2 = conjRectas.iterator();
        Recta recta1 = null;
        boolean mismaRecta = false;

        while(iterador1.hasNext()){
            recta1 = iterador1.next(); //se guarda la recta del primer conjunto para comparar con todo el segundo conjunto
            mismaRecta = false; //se asume que la recta no existe en el segundo conjunto
            //mientras no se encuentre una recta igual y el segundo conjunto tenga elementos, se busca una recta igual
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
    
    /*****************************************************/

    /**
    * @brief Sobrecarga del metodo contains para revisar si un conjunto contiene a una recta en particular.
    * @param recta La recta que se quiere saber si esta contenido en el conjunto.
    * @return true si el conjunto contiene a la recta, false en otro caso.
    */
    public boolean contains(Recta recta){
        Iterator<Recta> iterador = this.iterator();
        while(iterador.hasNext()){
            if(iterador.next().equals(recta)){
                return true;
            }
        }

        return false;
    }
    
    /*****************************************************/

    /**
    * @brief Sobrecarga del metodo add para agregar un elemento al conjunto.
    * @param recta La recta que se quiere agregar al conjunto.
    * @return true si el conjunto no contenia anteriormente al elemento y lo agrego, false en otro caso.
    */
    public boolean add(Recta recta){
        if(!this.contains(recta)){
            return super.add(recta);
        }

        return false;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para dibujar todas las rectas contenidos en el conjunto.
    */
    public void dibujar(){
        Iterator<Recta> iterador = this.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar();
        }
    }
    
    /*****************************************************/
    
    /**
    * @brief Metodo para dibujar todas las rectas contenidos en el conjunto.
    * @param colorRectas Color con el que se quiere pintar todas las rectas.
    */
    public void dibujar(color colorRectas){
        Iterator<Recta> iterador = this.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar(colorRectas);
        }
    }
}