import java.util.*;

/*
 * Este archivo contiene la clase ListaRecta, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */

class ListaRecta extends ArrayList<Recta>{

    /*****************************************************/
    
    /**
    * @brief Sobrecarga de la igualdad para revisar si dos listas de rectas son iguales.
    * @param listaRectas La otra lista de rectas con la que se quiera comparar si son iguales.
    * @return true si ambas listas contiene los mismos elementos en el mismo orden, false en otro caso.
    */
    public boolean equals(ArrayList<Recta> listaRectas)
    {
        //si las capacidades son diferentes, no pueden ser las mismas listas
        if(this.size() != listaRectas.size()){
            return false;
        }

        Iterator<Recta> iterador1 = this.iterator();
        Iterator<Recta> iterador2 = listaRectas.iterator();

        while(iterador1.hasNext()){
            //si alguno de los elmentos no es igual al elemento en el mismo lugar de la otra lista, entonces las listas no son iguales
            if(!iterador1.next().equals(iterador2.next())){
                return false;
            }
        }
        //si despues de comparar todos los elementos no hubo ninguno que fuese diferente, las listas son iguales
        return true;
    }

    /*****************************************************/

    /**
    * @brief Sobrecarga del metodo contains para revisar si la lista contiene a una recta en particular.
    * @param recta La recta que se quiere saber si esta contenido en la lista.
    * @return true si la lista contiene a la recta, false en otro caso.
    */
    public boolean contains(Recta recta)
    {
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
    * @brief Sobrecarga del metodo add para agregar un elemento la lista.
    * @param recta La recta que se quiere agregar la lista.
    * @return true si la lista no contenia anteriormente al elemento y lo agrego, false en otro caso.
    */
    public boolean add(Recta recta)
    {
        if(!this.contains(recta)){
            return super.add(recta);
        }

        return false;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo para dibujar todas las rectas contenidos en la lista.
    */
    public void dibujar()
    {
        Iterator<Recta> iterador = this.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar();
        }
    }
    
    /*****************************************************/
    
    /**
    * @brief Metodo para dibujar todas las rectas contenidos en la lista.
    * @param colorRectas Color con el que se quiere dibujar todas las rectas.
    */
    public void dibujar(color colorRectas)
    {
        Iterator<Recta> iterador = this.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar(colorRectas);
        }
    }
}