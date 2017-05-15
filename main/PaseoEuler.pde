/*
 * Este archivo contiene la implementación del microjuego del paseo de euler, donde se
 * presenta una gráfica en la cual se debe de mostrar un posible paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 15/Mayo/2017
 */
 
class PaseoEuler extends Microjuego{

/*****************************************************/
    private ArrayList<Grafica> listaGraf;
    private int indiceGraf;
    private int exitos;
    private Set<Recta> rectasUsuario;
    private Punto puntoActual;
    private final float TOLERANCIA = 10;
    private final int NUM_GRAF = 1;

/*****************************************************/

/*****************************************************/
    PaseoEuler(){
        this.fallos = 0;

        this.listaGraf = new ArrayList<Grafica>(NUM_GRAF);
        this.solucion = new HashSet<Recta>();
        this.puntoActual = null;

        /**Inicializa parametros******************************/

        Punto punto1 = new Punto(width*1/5.0, height*5/6.0);
        Punto punto2 = new Punto(width*1/5.0, height*2/6.0);
        Punto punto3 = new Punto(width/2.0, height*1/6.0);
        Punto punto4 = new Punto(width*4/5.0, height*2/6.0);
        Punto punto5 = new Punto(width*4/5.0, height*5/6.0);
        
        Set<Punto> puntos = new HashSet<Punto>();
        puntos.add(punto1);
        puntos.add(punto2);
        puntos.add(punto3);
        puntos.add(punto4);
        puntos.add(punto5);

        /**Agrega los puntos*********************************/

        Set<Recta> rectas = new HashSet<Recta>();
        rectas.add(new Recta(punto1, punto2));
        rectas.add(new Recta(punto1, punto4));
        rectas.add(new Recta(punto1, punto5));
        rectas.add(new Recta(punto2, punto1));
        rectas.add(new Recta(punto2, punto3));
        rectas.add(new Recta(punto2, punto4));
        rectas.add(new Recta(punto2, punto5));
        rectas.add(new Recta(punto3, punto2));
        rectas.add(new Recta(punto3, punto4));
        rectas.add(new Recta(punto4, punto2));
        rectas.add(new Recta(punto4, punto1));
        rectas.add(new Recta(punto4, punto5));
        rectas.add(new Recta(punto5, punto1));
        rectas.add(new Recta(punto5, punto2));
        rectas.add(new Recta(punto5, punto4));

        /**Agrega las rectas**********************************/

        this.indiceGraf = 0;
        this.listaGraf.add(this.indiceGraf, new Grafica(puntos, rectas));

        /**Agrega una grafica*********************************/
    }

    /**
     * @brief Dibuja la grafica seleccionada actualmente.
     */
    void dibujar(){
        this.listaGraf.get(this.indiceGraf).dibujar();
    }

    /**
     * @brief Dice si el juego ha fallado o no.
     */

    boolean obtenerFallo()
    {
        if(this.fallos >= 3){
            this.fallo = true;
        }
        
        return this.fallo;
    }
    
    boolean obtenerTermino()
    {   
         //revisa que el juego no haya terminado y que el usuario todavia puede fallar
        if(!this.termino && !this.fallo){
            //revisa si el juego no ha terminado
            Set<Rectas> rectasSolucion = this.listaGraf.get(indiceGraf).conjRectas;
            if(rectasUsuario.equals(rectasSolucion)){
                this.termino = true;
            }
        }
        
        return this.termino;
    }
    
    void calcularPuntaje()
    {
        //this.puntaje = (PUNTUACION_EXITO * this.exitos) - (PENALIZACION_FALLO * this.fallos);
    }
    
    void actualizar()
    {
        this.listaGraf.get(this.indiceGraf).dibujar();
    }
    
    void mousePressed(){
        if(puntoActual == null){
            
            Iterator<Punto> iterador = this.listaGraf.get(this.indiceActual).conjPuntos.iterator();
            Punto aux = null;

            while(iterador.hasNext() && this.puntoActuak == null){
                aux = iterador.next();
                if(mouseX > aux.obtenerX() - TOLERANCIA &&
                   mouseX < aux.obtenerX() + TOLERANCIA &&
                   mouseY > aux.obtenerY() - TOLERANCIA &&
                   mouseY < aux.obtenerY() + TOLERANCIA){
                    this.puntoActual = aux;
                }
            }
        }else{
                revisarPuntoActual();
            }
        }
    }

    void revisarPuntoSeleccionado(){
        Iterator<Punto> iterador = this.puntoActual.conexiones.iterator();
        Recta nuevaRecta = null;
        Punto aux = null;
        while(iterador.hasNext() && nuevaRecta == null){
            aux = iterador.next();
            if(mouseX > aux.obtenerX() - TOLERANCIA &&
               mouseX < aux.obtenerX() + TOLERANCIA &&
               mouseY > aux.obtenerY() - TOLERANCIA &&
               mouseY < aux.obtenerY() + TOLERANCIA){

			    nuevaRecta = new Recta(puntoSeleccionado, aux);

                if(!rectasUsuario.contains(nuevaRecta)){

                    rectasUsuario.add(nuevaRecta);
                    puntoSeleccionado = aux;
                    
                    if(obtenerTermino()){ //revisa si el juego termino
                        puntoSeleccionado = null;
                    }

                }else{
                    this.fallos += 1;
                    //si el usuario falla, termina el juego
                    (obtenerFallo()){
                        obtenerTermino();
                    }
                }
            }
        }
    }
    
    /*void mouseDragged(){
        if(puntoSeleccionado != null){
            line(puntoSeleccionado.obtenerX(), puntoSeleccionado.obtenerY(),
                 mouseX, mouseY); 
        }
    }*/
}
