import java.util.*;

/*****************************************************/
/*
public enum GraficaUsada {
    GRAFICA_1, GRAFICA_2, GRAFICA_3   
}
*/
/*****************************************************/
/*
public enum CODIGO {
    CODIGO_1, CODIGO_2, CODIGO_3
}
*/
/*****************************************************/

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
    private final int NUM_GRAF = /*3*/1;
    private int movimientosRegresados;
    private int vecesVaciadas;
    private final int PUNTUACION_BASE = 2000;
    private final int PENAL_REGRESAR = 100;
    private final int PENAL_VACIAR = 200;
    private int workingWidth;
    private int workingHeight;
    
    private color colorRectas;
    private color colorRectasUsuario;
    private color colorPuntos;
    private color colorFondo;

    /*****************************************************/
    
    /**
    * @brief Constructor del microjuego PaseoEuler. Esto crea diferentes graficas que se espera que el usuario le encuentre el paseo de euler
    *        correcto. Y el correcto dependera de el codigo en la bomba que dicta desde que punto de la grafica se debe iniciar.
    */
    public PaseoEuler(){
        this.ID = 3;
        this.fallos = 0;
        this.movimientosRegresados = 0;
        this.vecesVaciadas = 0;
        this.workingWidth = width;
        this.workingHeight = height;

        this.listaGraf = new ArrayList<Grafica>(NUM_GRAF);
        
        this.colorRectas = color(0, 0, 0);
        this.colorRectasUsuario = color(255, 255, 255);
        this.colorPuntos = color(0, 0, 0);
        this.colorFondo = color(127, 127, 127);

       this.generarGrafica();
    }

    /*****************************************************/

    /**
     * @brief Dibuja la grafica seleccionada actualmente.
     */
    void dibujar()
    {
        this.listaGraf.get(this.indiceGraf).dibujarRectas(this.colorRectas);

        this.listaGraf.get(this.indiceGraf).dibujarRectasUsuario(this.colorRectasUsuario);

        this.listaGraf.get(this.indiceGraf).dibujarPuntos(this.colorPuntos);
    }

    /*****************************************************/

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
    
    /*****************************************************/

    /**
    * @brief Metodo para saber si el usuario ya fallo el microjuego.
    * @return true si el usuario ya fallo y no puede seguir, false en otro caso.
    */
    boolean obtenerFallo()
    {
        return this.fallo;
    }
    
    /*****************************************************/

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
            if(this.listaGraf.get(this.indiceGraf).paseoCompletado()){
                this.termino = true;
                //si el punto inicial no concuerda con el primer elemento de la lista, el usuario fallo
                if(!this.listaGraf.get(indiceGraf).confirmarPuntoInicial()){
                    this.fallo = true;
                }
            }
        }

        return this.termino;
    }
    
    /*****************************************************/

    /**
    * @brief Obtiene la bandera que indica que el juego ya termino.
    * @return true si el juego ya termino, false en otro caso.
    */
    boolean obtenerTermino()
    {
        return this.termino;
    }
    
    /*****************************************************/

    /**
    * @brief Metodo que calcula el puntaje del microjuego. Solo se puede calcular el puntaje una vez que se haya completado el juego.
    */
    void calcularPuntaje()
    {
        int rectasGrafica = this.listaGraf.get(this.indiceGraf).conjPuntos.size();
        int rectasUsuario = this.listaGraf.get(this.indiceGraf).listaRectas.size();

        this.puntaje = this.PUNTUACION_BASE*rectasUsuario/rectasGrafica - (this.PENAL_REGRESAR * this.movimientosRegresados) -  (this.PENAL_VACIAR * this.vecesVaciadas);
        if(this.puntaje < 0){
            this.puntaje = 0;   
        }
    }
    
    /*****************************************************/

    /**
    * @brief Metodo que actualiza el estado del minijuego. Este metodo deberia ser llamado cada frame.
    */
    public void actualizar()
    {
        this.revisarTermino(); //revisa si el juego termino
        this.calcularPuntaje();
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
    
    /*****************************************************/

    /**
    * @brief Metodo que procesa el click hecho dependiendo de donde se hizo y si ya tenia un punto seleccionado.
    */
    public void procesarClick()
    {
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
    
    /*****************************************************/

    /**
    * @brief Revisa el punto actual con todas sus conexiones.
    */
    public void revisarPuntoActual()
    {
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
    
    /*****************************************************/

    /**
    * @brief Si el usuario tiene seleccionado algun punto, esto crea una linea del punto al cursor.
    */
    public void procesarArrastre()
    {

        if(listaGraf.get(indiceGraf).obtenerPuntoActual() != null){
            line(listaGraf.get(indiceGraf).obtenerPuntoActual().obtenerX(), listaGraf.get(indiceGraf).obtenerPuntoActual().obtenerY(),
                 mouseX, mouseY);
        }
    }
    
    /*****************************************************/
    
    /**
    * @brief Metodo que quita el ultimo movimiento hecho o vacia la grafica si se presiona la tecla 'b' o 'x' respectivamente
    */
    public void procesarTeclas()
    {
        if(key == 'b' || key == 'B'){
            if(!this.listaGraf.get(indiceGraf).obtenerListaRectas().isEmpty()){
                this.listaGraf.get(indiceGraf).removerUltimaRecta();
                this.movimientosRegresados += 1;
            }
        }
        
        if(key == 'x' || key == 'X'){
            if(!this.listaGraf.get(indiceGraf).obtenerListaRectas().isEmpty()){
                this.listaGraf.get(indiceGraf).vaciarLista();
                this.vecesVaciadas += 1;
            }
        }
    }
    
        
    /*****************************************************/
    
    /**
    * @brief Metodo para generar las graficas que se usaran en el juego. Esto depende del codigo de la bomba.    
    */
    public void generarGrafica()
    {
        int ultimoDigitoBomba = serial - serial/10 * 10; // obtiene el ultimo digito del serial
        
        
        final int GRAFICA_1 = 0;
        final int GRAFICA_2 = 1;
        //final int GRAFICA_3 = 2;
        
        Random r = new Random();
        int limiteInferior = 0;
        int limiteSuperior = 3;
        int indiceGraficaActual = r.nextInt(limiteSuperior - limiteInferior) + limiteInferior;
        this.indiceGraf = /*indiceGraficaActual*/0;
        
        SetPunto puntos;
        SetRecta rectas;
        Punto puntoInicial;
        /*
        switch(indiceGraficaActual){
            case GRAFICA_1:
                this.indiceGraf = GRAFICA_1;
                break;
            case GRAFICA_2:
                this.indiceGraf = GRAFICA_2;
                break;
                
            case GRAFICA_3:
                this.indiceGraf = GRAFICA_3;
                break;
                
            default:
                this.indiceGraf = GRAFICA_1;
        }
        */
        if(indiceGraficaActual  == GRAFICA_1){
            /**Inicializa parametros******************************/
    
            Punto punto1 = new Punto(this.workingWidth*1/5.0, this.workingHeight*5/6.0);
            Punto punto2 = new Punto(this.workingWidth*1/5.0, this.workingHeight*2/6.0);
            Punto punto3 = new Punto(this.workingWidth/2.0, this.workingHeight*1/6.0);
            Punto punto4 = new Punto(this.workingWidth*4/5.0, this.workingHeight*2/6.0);
            Punto punto5 = new Punto(this.workingWidth*4/5.0, this.workingHeight*5/6.0);
    
    
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
    
            puntos = new SetPunto();
            puntos.add(punto1);
            puntos.add(punto2);
            puntos.add(punto3);
            puntos.add(punto4);
            puntos.add(punto5);
    
            /**Agrega los puntos*********************************/
    
            rectas = new SetRecta();
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
            
            switch(ultimoDigitoBomba){
                case 0:
                case 3:
                case 6:
                case 9:
                    puntoInicial = punto1;     
                    break;
                case 1:
                case 4:
                case 7:
                    puntoInicial = punto5; 
                    break;
                case 2:
                case 5:
                case 8:
                    puntoInicial = punto1; 
                    break;
                default:
                    puntoInicial = punto5;
            }

            /**Agrega una grafica*********************************/
        }else if(indiceGraficaActual == GRAFICA_2){
            /**Inicializa parametros******************************/
    
            Punto punto1 = new Punto(this.workingWidth*1/8.0, this.workingHeight*3/7.0);
            Punto punto2 = new Punto(this.workingWidth*3/8.0, this.workingHeight*1/7.0);
            Punto punto3 = new Punto(this.workingWidth*5/8.0, this.workingHeight*1/7.0);
            Punto punto4 = new Punto(this.workingWidth*7/8.0, this.workingHeight*3/7.0);
            Punto punto5 = new Punto(this.workingWidth*4/8.0, this.workingHeight*4/7.0);
            Punto punto6 = new Punto(this.workingWidth*4/8.0, this.workingHeight*5/7.0);
    
    
            punto1.conexiones.add(punto2);
            punto1.conexiones.add(punto3);
            punto1.conexiones.add(punto5);
            punto1.conexiones.add(punto6);
    
            punto2.conexiones.add(punto1);
            punto2.conexiones.add(punto3);
            punto2.conexiones.add(punto4);
            punto2.conexiones.add(punto5);
    
            punto3.conexiones.add(punto1);
            punto3.conexiones.add(punto2);
            punto3.conexiones.add(punto4);
            punto3.conexiones.add(punto5);
    
            punto4.conexiones.add(punto2);
            punto4.conexiones.add(punto3);
            punto4.conexiones.add(punto5);
            punto4.conexiones.add(punto6);
    
            punto5.conexiones.add(punto1);
            punto5.conexiones.add(punto2);
            punto5.conexiones.add(punto3);
            punto5.conexiones.add(punto4);
            
            punto6.conexiones.add(punto1);
            punto6.conexiones.add(punto4);
    
            puntos = new SetPunto();
            puntos.add(punto1);
            puntos.add(punto2);
            puntos.add(punto3);
            puntos.add(punto4);
            puntos.add(punto5);
            puntos.add(punto6);
    
            /**Agrega los puntos*********************************/
    
            rectas = new SetRecta();
            rectas.add(new Recta(punto1, punto2));
            rectas.add(new Recta(punto1, punto3));
            rectas.add(new Recta(punto1, punto5));
    
            rectas.add(new Recta(punto2, punto1));
            rectas.add(new Recta(punto2, punto3));
            rectas.add(new Recta(punto2, punto4));
            rectas.add(new Recta(punto2, punto5));
    
            rectas.add(new Recta(punto3, punto1));
            rectas.add(new Recta(punto3, punto2));
            rectas.add(new Recta(punto3, punto4));
            rectas.add(new Recta(punto3, punto5));
    
            rectas.add(new Recta(punto4, punto2));
            rectas.add(new Recta(punto4, punto3));
            rectas.add(new Recta(punto4, punto5));
            rectas.add(new Recta(punto4, punto6));
    
            rectas.add(new Recta(punto5, punto1));
            rectas.add(new Recta(punto5, punto2));
            rectas.add(new Recta(punto5, punto3));
            rectas.add(new Recta(punto5, punto4));
            
            rectas.add(new Recta(punto6, punto1));
            rectas.add(new Recta(punto6, punto4));
    
            /**Agrega las rectas**********************************/
            
            switch(ultimoDigitoBomba){
                case 0:
                case 3:
                case 6:
                case 9:
                    puntoInicial = punto1;    
                    break;
                case 1:
                case 4:
                case 7:
                    puntoInicial = punto2; 
                    break;
                case 2:
                case 5:
                case 8:
                    puntoInicial = punto3; 
                    break;
                default:
                    puntoInicial = punto4;
            }
            
            /**Agrega una grafica*********************************/
        }else{
            /**Inicializa parametros******************************/
    
            Punto punto1 = new Punto(this.workingWidth*1/12.0, this.workingHeight*1/8.0);
            Punto punto2 = new Punto(this.workingWidth*4/12.0, this.workingHeight*2/8.0);
            Punto punto3 = new Punto(this.workingWidth*8/12.0, this.workingHeight*2/8.0);
            Punto punto4 = new Punto(this.workingWidth*11/12.0, this.workingHeight*5/8.0);
            Punto punto5 = new Punto(this.workingWidth*8/12.0, this.workingHeight*7/8.0);
            Punto punto6 = new Punto(this.workingWidth*4/12.0, this.workingHeight*7/8.0);
            Punto punto7 = new Punto(this.workingWidth*1/12.0, this.workingHeight*6/8.0);
    
    
            punto1.conexiones.add(punto2);
            punto1.conexiones.add(punto4);
            punto1.conexiones.add(punto5);
            punto1.conexiones.add(punto7);
    
            punto2.conexiones.add(punto1);
            punto2.conexiones.add(punto3);
            punto2.conexiones.add(punto5);
            punto2.conexiones.add(punto6);
            punto2.conexiones.add(punto7);
    
            punto3.conexiones.add(punto2);
            punto3.conexiones.add(punto4);
            punto3.conexiones.add(punto6);
            punto3.conexiones.add(punto7);
    
            punto4.conexiones.add(punto1);
            punto4.conexiones.add(punto3);
            punto4.conexiones.add(punto5);
            punto4.conexiones.add(punto7);
    
            punto5.conexiones.add(punto1);
            punto5.conexiones.add(punto2);
            punto5.conexiones.add(punto4);
            punto5.conexiones.add(punto6);
            
            punto6.conexiones.add(punto2);
            punto6.conexiones.add(punto3);
            punto6.conexiones.add(punto5);
            punto6.conexiones.add(punto7);
            
            punto7.conexiones.add(punto1);
            punto7.conexiones.add(punto2);
            punto7.conexiones.add(punto3);
            punto7.conexiones.add(punto4);
            punto7.conexiones.add(punto6);
    
            puntos = new SetPunto();
            puntos.add(punto1);
            puntos.add(punto2);
            puntos.add(punto3);
            puntos.add(punto4);
            puntos.add(punto5);
            puntos.add(punto6);
            puntos.add(punto7);
    
            /**Agrega los puntos*********************************/
            
            rectas = new SetRecta();
            rectas.add(new Recta(punto1, punto2));
            rectas.add(new Recta(punto1, punto4));
            rectas.add(new Recta(punto1, punto5));
            rectas.add(new Recta(punto1, punto7));
    
            rectas.add(new Recta(punto2, punto1));
            rectas.add(new Recta(punto2, punto3));
            rectas.add(new Recta(punto2, punto5));
            rectas.add(new Recta(punto2, punto6));
            rectas.add(new Recta(punto2, punto7));
    
            rectas.add(new Recta(punto3, punto2));
            rectas.add(new Recta(punto3, punto4));
            rectas.add(new Recta(punto3, punto6));
            rectas.add(new Recta(punto3, punto7));
    
            rectas.add(new Recta(punto4, punto1));
            rectas.add(new Recta(punto4, punto3));
            rectas.add(new Recta(punto4, punto5));
            rectas.add(new Recta(punto4, punto7));
    
            rectas.add(new Recta(punto5, punto1));
            rectas.add(new Recta(punto5, punto2));
            rectas.add(new Recta(punto5, punto4));
            rectas.add(new Recta(punto5, punto6));
            
            rectas.add(new Recta(punto6, punto2));
            rectas.add(new Recta(punto6, punto3));
            rectas.add(new Recta(punto6, punto5));
            rectas.add(new Recta(punto6, punto7));
            
            rectas.add(new Recta(punto7, punto1));
            rectas.add(new Recta(punto7, punto2));
            rectas.add(new Recta(punto7, punto3));
            rectas.add(new Recta(punto7, punto4));
            rectas.add(new Recta(punto7, punto6));
    
            /**Agrega las rectas**********************************/
            
            switch(ultimoDigitoBomba){
                case 0:
                case 3:
                case 6:
                case 9:
                    puntoInicial = punto2;   
                    break;
                case 1:
                case 4:
                case 7:
                    puntoInicial = punto7;
                    break;
                case 2:
                case 5:
                case 8:
                    puntoInicial = punto2;
                    break;
                default:
                    puntoInicial = punto7;
            }

            /**Agrega una grafica*********************************/
        }
        
        this.listaGraf.add(this.indiceGraf, new Grafica(puntos, rectas, puntoInicial));
        println("ultimo digito bomba: " + ultimoDigitoBomba);
    }
}