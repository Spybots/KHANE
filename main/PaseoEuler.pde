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
        this.rectasUsuario = new HashSet<Recta>();
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
        Iterator<Recta> iterador = this.rectasUsuario.iterator();
        while(iterador.hasNext()){
            iterador.next().dibujar();    
        }

        stroke(0);
        this.listaGraf.get(this.indiceGraf).dibujarPuntos();
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
            Set<Recta> rectasSolucion = this.listaGraf.get(indiceGraf).conjRectas;
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
        background(127);
        this.dibujar();
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
        Recta nuevaRecta2 = null;
        Punto aux = null;
        while(iterador.hasNext() && nuevaRecta1 == null){
            aux = iterador.next();
            if(mouseX > aux.obtenerX() - TOLERANCIA &&
               mouseX < aux.obtenerX() + TOLERANCIA &&
               mouseY > aux.obtenerY() - TOLERANCIA &&
               mouseY < aux.obtenerY() + TOLERANCIA){

			    nuevaRecta1 = new Recta(puntoActual, aux);
                nuevaRecta2 = new Recta(aux, puntoActual);

                if(!rectasUsuario.contains(nuevaRecta1) &&
                   !rectasUsuario.contains(nuevaRecta2)){

                    text("La recta no esta contenida", 100, 50);

                    rectasUsuario.add(nuevaRecta1);
                    puntoActual = aux;
                    
                    if(obtenerTermino()){ //revisa si el juego termino
                        puntoActual = null;
                    }

                }else{

                    text("La recta ya esta contenida", 100, 50);
                    this.fallos += 1;
                    //si el usuario falla, termina el juego
                    if(obtenerFallo()){
                        obtenerTermino();
                    }
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

PaseoEuler paseo = null;
boolean someKey = false;

/*
void setup(){
     size(800, 800);
     
     paseo = new PaseoEuler();
}

void draw(){
     paseo.actualizar();
     
     if(mousePressed){
         paseo.procesarClick(); 
     }
     
     paseo.procesarArrastre();
     
    textMode(CENTER);
    
    if(paseo.termino){
         text("El juego se acabo", width/2, 75);  
    }else{
        text("El juego NO se ha acabado", width/2, 75); 
    }
    
    if(paseo.puntoActual != null)
        text("El punto actual es " + paseo.puntoActual.obtenerX() + " " + paseo.puntoActual.obtenerY() , width/2, 100);
    else
        text("El punto actual es NULL", width/2, 100);
     
     if(paseo.rectasUsuario.equals(paseo.listaGraf.get(0).conjRectas)){
            text("Los conjuntos son iguales", width/2, 20);
        }else{
            text("Los conjuntos NO son iguales", width/2, 20);
        }
     
     if(keyPressed){
         background(127);
         Iterator<Recta> iterador = paseo.rectasUsuario.iterator();
         while(iterador.hasNext()){
              iterador.next().dibujar();   
         }
     }
}
*/