import java.util.*;
/*
 * Este archivo contiene la clase Grafica, una clase auxiliar para el microjuego del paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */

class Grafica{
    private SetPunto conjPuntos;
    private SetRecta conjRectas;
    private Punto puntoActual;
    private Punto puntoInicial; //es el punto con el que el usuario debe comenzar a unir puntos a la grafica o estara incorrecta
    private ListaRecta listaRectas; //lista con las rectas que el usuario vaya agregando a lo largo del juego


    /**
    * @brief Constructor que recibe dos conjuntos, uno de puntos y uno de rectas y crea una grafica con esos conjuntos.
    * @param conjPuntos Conjunto de puntos de la grafica
    * @param conjRectas Conjunto de rectas de la grafica
    */
    public Grafica(SetPunto conjPuntos, SetRecta conjRectas, Punto puntoInicial){
        this.conjPuntos = conjPuntos;
        this.conjRectas = conjRectas;
        this.puntoActual = null;
        this.puntoInicial = puntoInicial;
        this.listaRectas = new ListaRecta(/*this.conjRectas.size()*/); //crea una lista de rectas de la misma capacidad que el conjunto de rectas
    }

    /**
    * @brief Metodo para obtener el punto actual.
    * @return Punto actual
    */
    public Punto obtenerPuntoActual(){
        return this.puntoActual;
    }

    /**
    * @brief Metodo para cambiar el valor del punto actual.
    * @param nuevoPunto Nuevo valor para el punto actual.
    */
    public void asignarPuntoActual(Punto nuevoPunto){
        this.puntoActual = nuevoPunto;
    }

    /**
    * @brief Metodo para vaciar la lista de rectas.
    */
    public void vaciarLista(){
        this.listaRectas.clear();
        this.puntoActual = null;
    }

    /**
    * @brief Metodo que compara el primer elemento de la lista de rectas con el punto inicial
    * @return true si el primer elemento de la lista es el mismo que el punto inicial de la grafica
    */
    public boolean confirmarPuntoInicial(){
        //si el primer elemento de la lista o el punto inicial es nulo, entonces no puede ser iguales
        if(this.listaRectas.size() <= 0 || this.listaRectas.get(0) == null || this.puntoInicial == null){
            return false;
        }

        //revisa que el primer punto de la primer recta sea el punto inicial
        if(this.listaRectas.get(0).obtenerPunto1().equals(this.puntoInicial)){
            return true;
        }

        return false;
    }

    /**
    * @brief Metodo para agregar un elemento a la lista de rectas del usuario.
    * @param recta Recta que se quiere agregar a la lista de rectas
    * @return true si la recta se agrego porque todavia no existia en la lista pero si en el conjunto, false en otro caso
    */
    public boolean agregarRectaLista(Recta recta){
        /*if(this.listaRectas.add(recta)){ //si agrego la recta a la lista
            if(this.puntoInicial == null){
                this.puntoInicial = recta;
            }

            return true;
        }

        return false;*/

        return this.listaRectas.add(recta);
    }

    /**
    * @brief Metodo para remover el ultimo elemento de la lista de rectas el usuario. Efectivamente regresando un 'turno'.
    * @return true si la lista no esta vacio y se quito el ultimo elemento, false en otro caso.
    */
    public boolean removerUltimaRecta(){
        if(!this.listaRectas.isEmpty()){
            Recta rectaBorrar = this.listaRectas.get(this.listaRectas.size() - 1);

            //se reajusta el punto actual
            if(this.puntoActual == rectaBorrar.obtenerPunto1()){
                this.puntoActual = rectaBorrar.obtenerPunto2();
            }else{
                this.puntoActual = rectaBorrar.obtenerPunto1();
            }

            this.listaRectas.remove(rectaBorrar);

            //si la lista se vacio al remover el elemento entonces el punto actual se hace nulo
            if(this.listaRectas.isEmpty()){
                this.puntoActual = null;
            }

            return true;
        }
        return false;
    }

    /**
    * @brief Metodo que revisa que todos los elementos de la lista esten contenidos en el conjunto, en cuyo caso el paseo fue encontrado.
    * @return true si la lista de rectas tiene los mismos elmentos que el conjunto de rectas.
    */
    public boolean paseoCompletado(){
        //si los tamaños son diferentes, no pueden contener los mismos elementos
        if( this.listaRectas.size() != this.conjRectas.size() ){
            return false;
        }

        //revisa que cada elemento de la lista este contenido en el conjunto
        for(Recta recta : this.listaRectas){
            //si algun punto no es contenido, no contiene los mismos elementos
            if(!this.conjRectas.contains(recta)){
                return false;
            }
        }
        //si todos los elementos de la lista estan contenidos en el conjunto, regresa true
        return true;
    }
    
    /**
    * @brief Metodo para dibujar todas las rectas, todas las rectas que ha hecho el usuario y todos los puntos de la grafica.
    */
    public void dibujar(){
        Iterator<Recta> iteradorRecta = this.conjRectas.iterator();
        while(iteradorRecta.hasNext()){
           iteradorRecta.next().dibujar();
        }

        for(Recta recta : this.listaRectas){
            recta.dibujar();
        }

        Iterator<Punto> iteradorPunto = this.conjPuntos.iterator();
        while(iteradorPunto.hasNext()){
           iteradorPunto.next().dibujar();
        }
    }

    /**
    * @brief Metodo para dibujar todas las rectas de la grafica.
    */
  public void dibujarRectas(){
        Iterator<Recta> iteradorRecta = this.conjRectas.iterator();
        while(iteradorRecta.hasNext()){
           iteradorRecta.next().dibujar();
        }
    }

    /**
    * @brief Metodo para dibujar todas las rectas del usuario de la grafica.
    */
  public void dibujarRectasUsuario(){
        for(Recta recta : this.listaRectas){
            recta.dibujar();
        }
    }

    /**
    * @brief Metodo para dibujar todos los puntos de la grafica.
    */
    public void dibujarPuntos(){
        Iterator<Punto> iteradorPunto = this.conjPuntos.iterator();
        while(iteradorPunto.hasNext()){
           iteradorPunto.next().dibujar();
        }
    }

    /**
    * @brief Metodo para dibujar todas las rectas, todas las rectas que ha hecho el usuario y todos los puntos de la grafica.
    * @param colorConjuntoRectas Color con el cual pintar al conjunto de rectas.
    * @param colorListaRectas Color con el cual pintar a la lista de rectas.
    * @param colorConjuntoPuntos Color con el cual pintar al conjunto de puntos.
    */
    public void dibujar(color colorConjuntoRectas, color colorListaRectas, color colorConjuntoPuntos){
        Iterator<Recta> iteradorRecta = this.conjRectas.iterator();
        while(iteradorRecta.hasNext()){
           iteradorRecta.next().dibujar(colorConjuntoRectas);
        }

        for(Recta recta : this.listaRectas){
            recta.dibujar(colorListaRectas);
        }

        Iterator<Punto> iteradorPunto = this.conjPuntos.iterator();
        while(iteradorPunto.hasNext()){
           iteradorPunto.next().dibujar(colorConjuntoPuntos);
        }
    }
    
    /**
    * @brief Metodo para dibujar todas las rectas de la grafica.
    * @param colorConjuntoRectas Color con el cual pintar al conjunto de rectas.
    */
  public void dibujarRectas(color colorConjuntoRectas){
        Iterator<Recta> iteradorRecta = this.conjRectas.iterator();
        while(iteradorRecta.hasNext()){
           iteradorRecta.next().dibujar(colorConjuntoRectas);
        }
    }

    /**
    * @brief Metodo para dibujar todas las rectas del usuario de la grafica.
    * @param colorListaRectas Color con el cual pintar a la lista de rectas.
    */
  public void dibujarRectasUsuario(color colorListaRectas){
        for(Recta recta : this.listaRectas){
            recta.dibujar(colorListaRectas);
        }
    }

    /**
    * @brief Metodo para dibujar todos los puntos de la grafica.
    * @param colorConjuntoPuntos Color con el cual pintar al conjunto de puntos.
    */
    public void dibujarPuntos(color colorConjuntoPuntos){
        Iterator<Punto> iteradorPunto = this.conjPuntos.iterator();
        while(iteradorPunto.hasNext()){
           iteradorPunto.next().dibujar(colorConjuntoPuntos);
        }
    }
}