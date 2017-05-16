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
    private SetRecta rectasUsuario;
    private Punto puntoActual;
    private final float TOLERANCIA = 10;
    private final int NUM_GRAF = 1;

    /*****************************************************/

    /*****************************************************/
    PaseoEuler(){
        this.fallos = 0;

        this.listaGraf = new ArrayList<Grafica>(NUM_GRAF);
        this.rectasUsuario = new SetRecta();
        this.puntoActual = null;

        /**Inicializa parametros******************************/

        Punto punto1 = new Punto(width*1/5.0, height*5/6.0);
        Punto punto2 = new Punto(width*1/5.0, height*2/6.0);
        Punto punto3 = new Punto(width/2.0, height*1/6.0);
        Punto punto4 = new Punto(width*4/5.0, height*2/6.0);
        Punto punto5 = new Punto(width*4/5.0, height*5/6.0);
        

        punto1.conexiones.add(punto2);
        punto1.conexiones.add(punto4);
        punto1.conexiones.add(punto5);

        punto2.conexiones.add(punto1);
        punto2.conexiones.add(punto3);
        punto2.conexiones.add(punto4);
        punto2.conexiones.add(punto5);

        punto3.conexiones.add(punto2);
        punto3.conexiones.add(punto4);

        punto4.conexiones.add(punto3);
        punto4.conexiones.add(punto2);
        punto4.conexiones.add(punto1);
        punto4.conexiones.add(punto5);

        punto5.conexiones.add(punto1);
        punto5.conexiones.add(punto2);
        punto5.conexiones.add(punto4);
        
        SetPunto puntos = new SetPunto();
        puntos.add(punto1);
        puntos.add(punto2);
        puntos.add(punto3);
        puntos.add(punto4);
        puntos.add(punto5);

        /**Agrega los puntos*********************************/

        SetRecta rectas = new SetRecta();
        rectas.add(new Recta(punto1, punto2));
        rectas.add(new Recta(punto1, punto4));
        rectas.add(new Recta(punto1, punto5));

        rectas.add(new Recta(punto2, punto1));
        rectas.add(new Recta(punto2, punto3));
        rectas.add(new Recta(punto2, punto4));
        rectas.add(new Recta(punto2, punto5));

        rectas.add(new Recta(punto3, punto2));
        rectas.add(new Recta(punto3, punto4));

        rectas.add(new Recta(punto4, punto3));
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
        stroke(0);
        this.listaGraf.get(this.indiceGraf).dibujarRectas();

        stroke(255);
        this.rectasUsuario.dibujar();

        stroke(0);
        this.listaGraf.get(this.indiceGraf).dibujarPuntos();
    }

    /**
     * @brief Dice si el juego ha fallado o no.
     */

    boolean revisarFallo()
    {
        if(this.fallos >= 3){
            this.fallo = true;
        }
        
        return this.fallo;
    }

    boolean obtenerFallo(){
        return this.fallo;
    }
    
    boolean revisarTermino()
    {   
         //revisa que el juego no haya terminado y que el usuario todavia puede fallar

        if(this.fallo){
            this.termino = true;
        }
        if(!this.termino){
            //revisa si el juego no ha terminado
            SetRecta rectasSolucion = this.listaGraf.get(indiceGraf).conjRectas;
            //como el paseo de euler ocupa que todas las rectas esten ocupadas, 
            //con que el tamaño de las rectas del usuario sea iguales es suficiente           
            if(rectasUsuario.size() == rectasSolucion.size()){
                this.termino = true;
            }
        }
        
        return this.termino;
    }

    boolean obtenerTermino(){
        return this.termino;
    }
    
    void calcularPuntaje()
    {
        //this.puntaje = (PUNTUACION_EXITO * this.exitos) - (PENALIZACION_FALLO * this.fallos);
    }
    
    void actualizar()
    {
        background(127);
        this.revisarFallo();
        this.revisarTermino();
        if(!this.termino){
            this.dibujar();
            this.procesarArrastre();
        }else{
            text("El juego termino", width/2, 10);
            if(!this.fallo){
                text("Ganaste!", width/2, 20);
            }else{
                text("Perdiste...", width/2, 20);
            }
        }
    }
    
    void procesarClick(){
        if(puntoActual == null){
            
            Iterator<Punto> iterador = this.listaGraf.get(this.indiceGraf).conjPuntos.iterator();
            Punto aux = null;

            while(iterador.hasNext() && this.puntoActual == null){
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

    void revisarPuntoActual(){
        Iterator<Punto> iterador = this.puntoActual.conexiones.iterator();
        Recta nuevaRecta1 = null;
        Punto aux = null;
        while(iterador.hasNext() && nuevaRecta1 == null){
            aux = iterador.next();
            if(mouseX > aux.obtenerX() - TOLERANCIA &&
               mouseX < aux.obtenerX() + TOLERANCIA &&
               mouseY > aux.obtenerY() - TOLERANCIA &&
               mouseY < aux.obtenerY() + TOLERANCIA){

			    nuevaRecta1 = new Recta(puntoActual, aux);

                if(!rectasUsuario.contains(nuevaRecta1)){
                    rectasUsuario.add(nuevaRecta1);
                    puntoActual = aux;
                }else{
                    this.fallos += 1;
                }
            }
        }
    }
    
    void procesarArrastre(){
        if(puntoActual != null){
            line(puntoActual.obtenerX(), puntoActual.obtenerY(),
                 mouseX, mouseY); 
        }
    }
}
