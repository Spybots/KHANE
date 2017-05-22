import java.util.*;

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
    private final float TOLERANCIA = 10;
    private final int NUM_GRAF = 1;
    private int movimientosRegresados;
    private int vecesVaciadas;
    private final int PUNTUACION_BASE = 500;
    private final int PENAL_REGRESAR = 10;
    private final int PENAL_VACIAR = 40;
    private color colorRectas;
    private color colorRectasUsuario;
    private color colorPuntos;
    private color colorFondo;

    /*****************************************************/

    /*****************************************************/
    /**
    * @brief Constructor del microjuego PaseoEuler. Esto crea diferentes graficas que se espera que el usuario le encuentre el paseo de euler
    *        correcto. Y el correcto dependera de el codigo en la bomba que dicta desde que punto de la grafica se debe iniciar.
    */
    public PaseoEuler(){
        this.fallos = 0;
        this.movimientosRegresados = 0;
        this.vecesVaciadas = 0;

        this.listaGraf = new ArrayList<Grafica>(NUM_GRAF);
        
        this.colorRectas = color(0, 0, 0);
        this.colorRectasUsuario = color(255, 255, 255);
        this.colorPuntos = color(0, 0, 0);
        this.colorFondo = color(127, 127, 127);

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
        this.listaGraf.add(this.indiceGraf, new Grafica(puntos, rectas, punto1));

        /**Agrega una grafica*********************************/
    }

    /**
     * @brief Dibuja la grafica seleccionada actualmente.
     */
    void dibujar(){
        this.listaGraf.get(this.indiceGraf).dibujarRectas(this.colorRectas);

        this.listaGraf.get(this.indiceGraf).dibujarRectasUsuario(this.colorRectasUsuario);

        this.listaGraf.get(this.indiceGraf).dibujarPuntos(this.colorPuntos);
    }

    /**
     * @brief Dice si el juego ha fallado o no.
     * @return true si el juego ya acabo, false en otro caso.
     */
    boolean revisarFallo()
    {
        if(this.fallos >= 3){
            this.fallo = true;
        }

        return this.fallo;
    }

    /**
    * @brief Metodo para saber si el usuario ya fallo el microjuego.
    * @return true si el usuario ya fallo y no puede seguir, false en otro caso.
    */
    boolean obtenerFallo(){
        return this.fallo;
    }

    /**
    * @brief Metodo que revisa si el juego ya termino porque el usuario lo completo o si el usuario fallo.
    * @return true si el juego ya termino, false en otro caso.
    */
    boolean revisarTermino()
    {
         //revisa que el juego no haya terminado y que el usuario todavia puede fallar

        if(this.revisarFallo()){
            this.termino = true;
        }
        if(!this.termino){
        /*
            //revisa si el juego no ha terminado
            SetRecta rectasSolucion = this.listaGraf.get(indiceGraf).conjRectas;
            //como el paseo de euler ocupa que todas las rectas esten ocupadas,
            //con que el tamaño de las rectas del usuario sea iguales es suficiente
            if(rectasUsuario.size() == rectasSolucion.size()){
                if(this.grafica.get(indiceGraf).confirmarPuntoInicial()){
                    this.termino = true;
                }else{
                    this.termino = false;
                }
            }
        */
            if(this.listaGraf.get(indiceGraf).paseoCompletado()){
                this.termino = true;
                //si el punto inicial no concuerda con el primer elemento de la lista, el usuario fallo
                if(!this.listaGraf.get(indiceGraf).confirmarPuntoInicial()){
                    this.fallo = true;
                }
            }
        }

        return this.termino;
    }

    /**
    * @brief Obtiene la bandera que indica que el juego ya termino.
    * @return true si el juego ya termino, false en otro caso.
    */
    boolean obtenerTermino(){
        return this.termino;
    }

    /**
    * @brief Metodo que calcula el puntaje del microjuego. Solo se puede calcular el puntaje una vez que se haya completado el juego.
    */
    void calcularPuntaje()
    {
        if(this.termino){
            this.puntaje = this.PUNTUACION_BASE - (this.PENAL_REGRESAR * this.movimientosRegresados) -  (this.PENAL_VACIAR * this.vecesVaciadas);
        }
    }

    /**
    * @brief Metodo que actualiza el estado del minijuego. Este metodo deberia ser llamado cada frame.
    */
    void actualizar()
    {
        this.revisarTermino(); //revisa si el juego termino
        //si el juego no ha terminado, repinta el fondo, dibuja la grafica y dibuja la linea del ultimo vertice al cursor
        if(!this.termino){
            background(this.colorFondo);
            this.dibujar();
            this.procesarArrastre();
        }else{
            //si el juego termino, imprime un mensaje de victoria o derrota dependiendo de si el jugador fallo o no
            text("El juego termino", width/2, 10);
            if(!this.fallo){
                text("Ganaste!", width/2, 20);
            }else{
                text("Perdiste...", width/2, 20);
            }
        }
    }

    /**
    * @brief Metodo que procesa el click hecho dependiendo de donde se hizo y si ya tenia un punto seleccionado.
    */
    void procesarClick(){
        if(listaGraf.get(indiceGraf).obtenerPuntoActual() == null){

            Iterator<Punto> iterador = this.listaGraf.get(this.indiceGraf).conjPuntos.iterator();
            Punto aux = null;

            while(iterador.hasNext() && this.listaGraf.get(indiceGraf).obtenerPuntoActual() == null){
                aux = iterador.next();
                if(mouseX > aux.obtenerX() - TOLERANCIA &&
                   mouseX < aux.obtenerX() + TOLERANCIA &&
                   mouseY > aux.obtenerY() - TOLERANCIA &&
                   mouseY < aux.obtenerY() + TOLERANCIA){
          if(!revisarTermino()){
            this.listaGraf.get(indiceGraf).asignarPuntoActual(aux);
          }else{
            this.listaGraf.get(indiceGraf).asignarPuntoActual(null);
          }
                }
            }
        }else{
            revisarPuntoActual();
        }
    }

    /**
    * @brief Revisa el punto actual con todas sus conexiones.
    */
    void revisarPuntoActual(){
        Iterator<Punto> iterador = this.listaGraf.get(indiceGraf).obtenerPuntoActual().conexiones.iterator();
        Recta nuevaRecta1 = null;
        Punto aux = null;
        while(iterador.hasNext() && nuevaRecta1 == null){
            aux = iterador.next();
            if(mouseX > aux.obtenerX() - TOLERANCIA &&
               mouseX < aux.obtenerX() + TOLERANCIA &&
               mouseY > aux.obtenerY() - TOLERANCIA &&
               mouseY < aux.obtenerY() + TOLERANCIA){

          nuevaRecta1 = new Recta(this.listaGraf.get(indiceGraf).obtenerPuntoActual(), aux);

          //si pudo agregar exitosamente la nueva recta a la lista de rectas, entonces cambia el punto actual. En otro caso
          //agrega un fallo
          if(this.listaGraf.get(indiceGraf).agregarRectaLista(nuevaRecta1)){
                    if(!revisarTermino()){
            this.listaGraf.get(indiceGraf).asignarPuntoActual(aux);
          }else{
            this.listaGraf.get(indiceGraf).asignarPuntoActual(null);
          }
          }else{
                    this.fallos += 1;
          }
            }
        }
    }

    /**
    * @brief Si el usuario tiene seleccionado algun punto, esto crea una linea del punto al cursor.
    */
    void procesarArrastre(){

        if(listaGraf.get(indiceGraf).obtenerPuntoActual() != null){
            line(listaGraf.get(indiceGraf).obtenerPuntoActual().obtenerX(), listaGraf.get(indiceGraf).obtenerPuntoActual().obtenerY(),
                 mouseX, mouseY);
        }
    }
    
    void procesarTeclas(){
        if(key == 'b' || key == 'B'){
            this.listaGraf.get(indiceGraf).removerUltimaRecta();
            this.movimientosRegresados += 1;
        }
        
        if(key == 'x' || key == 'X'){
            this.listaGraf.get(indiceGraf).vaciarLista();
            this.vecesVaciadas += 1;
        }
    }
}