/*
 * Este archivo contiene las funciones principales de KHANE.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 15/Mayo/2017.
 */

PFont fuenteTextoDefault;

final int FPS_CAP = 60;

//Variables que indican que debe desplegar en pantalla.
boolean muestraInicio = true;
boolean muestraMenu = false;
boolean muestraJuego = false;
boolean muestraPuntaje = false;
boolean muestraOpciones = false;

// Variables globales sobre los microjuegos de KHANE.
final int NUMERO_MICROJUEGOS = 4; 
ArrayList<Microjuego> microjuegos;

/**
 * @brief Inicializa varios elementos del juego.
 */
void setup()
{
    fullScreen(P3D);
    frameRate(FPS_CAP);
    background(0, 0, 0);
    
    //Carga el texto usado por la interfaz del juego.
    fuenteTextoDefault = createFont("Georgia", 32);
    textFont(fuenteTextoDefault);
     //<>// //<>//
    //Crea los modelos que seran usados en la pantalla de inicio.
    crearModelos(); //<>//
    
    crearBotones();
}

/**
 * @brief Actualiza lo que el usuario ve en pantalla acorde al punto en el programa en el que esté. 
 */
void draw()
{
    background(0, 0, 0); // Bien negro.
    
    
    if (muestraInicio) {
        desplegarVentanaComienzo();
    } else if (muestraMenu) {
        desplegarMenu();
    } else if (muestraJuego) {
        actualizarJuego();
    } else if (muestraPuntaje) {
        // Desplegar puntajes.
    } else if (muestraOpciones) {
        // Desplegar opciones.
    }
    
    // REMOVER DESPUES DE DEBUGUEAR.
    textSize(16);
    text("FPS: " + int(frameRate), 40, 20);
}

/*****************************************************/

/**
 * @brief Espera el click de un ratón para interactuar con el usuario..
 */
void mouseClicked()
{   
    if (muestraInicio) {
        mostrarAnimacionMenu = true;
    } else if (muestraMenu) {
        procesarClickMenu();
    } else if (muestraJuego) {
        procesarClickBomba();
    } else if (muestraPuntaje) {
        // Hacer algo con puntajes.
    } else if (muestraOpciones) {
        // Hacer algo con opciones.
    }
}

/*****************************************************/