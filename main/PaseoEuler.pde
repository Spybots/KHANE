/*
 * Este archivo contiene la implementación del microjuego del paseo de euler, donde se
 * presenta una gráfica en la cual se debe de mostrar un posible paseo de euler.
 *
 * Autor: Sotomayor Samaniego Luis Fernando
 * Última modificación: 13/Mayo/2017
 */
 
class PaseoEuler extends Microjuego{
    private Grafica[] grafica;    
    private int nGraficas;
    private int exitos;

    PaseoEuler(){
        this.nGraficas = 1;
        this.grafica = new Grafica[this.nGraficas];
        int nPuntos = 5;
        int nRectas = 8;
        
        Punto punto1 = new Punto(width*1/5.0, height*5/6.0);
        Punto punto2 = new Punto(width*1/5.0, height*2/6.0);
        Punto punto3 = new Punto(width/2.0, height*1/6.0);
        Punto punto4 = new Punto(width*4/5.0, height*2/6.0);
        Punto punto5 = new Punto(width*4/5.0, height*5/6.0);

        Punto[] puntos = {punto1, punto2, punto3, punto4, punto5};

        Recta recta1 = new Recta(punto1, punto2);
        Recta recta2 = new Recta(punto1, punto4);
        Recta recta3 = new Recta(punto1, punto5);

        //Recta recta4 = new Recta(punto2, punto1);
        Recta recta5 = new Recta(punto2, punto3);
        Recta recta6 = new Recta(punto2, punto4);
        Recta recta7 = new Recta(punto2, punto5);

        //Recta recta8 = new Recta(punto3, punto2);
        Recta recta9 = new Recta(punto3, punto4);

        //Recta recta10 = new Recta(punto4, punto2);
        //Recta recta11 = new Recta(punto4, punto1);
        Recta recta12 = new Recta(punto4, punto5);

        //Recta recta13 = new Recta(punto5, punto1);
        //Recta recta14 = new Recta(punto5, punto2);
        //Recta recta15 = new Recta(punto5, punto4);

        Recta[] rectas = {recta1, recta2, recta3,
                          recta5, recta6, recta7,
                          recta9,
                          recta12};

        this.grafica[0] = new Grafica(puntos, rectas, nPuntos, nRectas);
    }

    void dibujar(int indiceGrafica){
        if(indiceGrafica >= 0 && indiceGrafica < nGraficas){
            this.grafica[indiceGrafica].dibujar();
        }
    }

    boolean obtenerFallo()
    {
        return this.fallo;
    }
    
    boolean obtenerTermino()
    {   
        if (this.exitos == NUM_EXITOS_PARA_TERMINAR) {
            this.termino = true;
        } else {
            this.termino = false;
        }
        
        return this.termino;
    }
    
    void calcularPuntaje()
    {
        this.puntaje = (PUNTUACION_EXITO * this.exitos) - (PENALIZACION_FALLO * this.fallos);
    }
    
    void actualizar()
    {
        this.dibujar(0);
    }
}
