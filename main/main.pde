/*
 * Este archivo contiene las funciones principales de KHANE.
 *
 * Ultima modificacion: 15/Mayo/2017.
 */

Microjuego juego;

PFont fuenteTextoDefault;

final int FPS_CAP = 60;

//Variables que indican que debe desplegar en pantalla.
boolean muestraInicio = true;
boolean muestraMenu = false;
boolean muestraJuego = false;
boolean muestraPuntaje = false;
boolean muestraOpciones = false;

/**
 *
 */
void setup()
{
    size(1366, 768, P3D);
    frameRate(FPS_CAP);
    background(0, 0, 0);
    
    //Carga el texto usado por la interfaz del juego.
    fuenteTextoDefault = createFont("Georgia", 32);
    textFont(fuenteTextoDefault);
    
    //Crea los modelos que seran usados en la pantalla de inicio.
    crearModelos(); //<>//
    
    juego = new Discos();
}

/**
 *
 */
void draw()
{
    background(0, 0, 0); // Bien negro.
    
    
    if (muestraInicio) {
        desplegarVentanaComienzo();
    } else if (muestraMenu) {
        desplegarMenu();
    } else if (muestraJuego) {
        juego.actualizar();
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
        // Hacer algo con el menu.
    } else if (muestraJuego) {
        juego.procesarClick();
    } else if (muestraPuntaje) {
        // Hacer algo con puntajes.
    } else if (muestraOpciones) {
        // Hacer algo con opciones.
    }
}