/*
 * Este archivo contiene las funciones principales de KHANE.
 *
 * Ultima modificacion: 01/Mayo/2017.
 */

PFont fuenteTextoDefault; //defaultTextFont

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
}

/**
 *
 */
void draw()
{
    background(0, 0, 0); //Bien negro.
    
    if (muestraInicio) {
        desplegarVentanaComienzo();
    } else if (muestraMenu) {
        desplegarMenu();
    }
}