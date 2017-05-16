/*
 * Este archivo contiene las funciones que despliegan el juego actual de KHANE.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 15/Mayo/2017.
 */
 
/*****************************************************/

boolean mostrarMicrojuego = false;
short microjuegoActual = 0, errores = 0;
final short NUMERO_ERRORES_FIN = 3; // Número de errores para Game Over.

/*****************************************************/

/**
 * @brief Actualiza el estado actual del microjuego que está jugando el usuario o del
 * maletín para seleccionar el nivel.
 */
void actualizarJuego()
{
    if (mostrarMicrojuego) {
        microjuegos.get(microjuegoActual).actualizar();
        
        // No permite que el usuario visualice un microjuego ya terminado.
        if (microjuegos.get(microjuegoActual).obtenerTermino()) {
            mostrarMicrojuego = false;
        }
        
        if (microjuegos.get(microjuegoActual).obtenerFallo()) {
            errores++;
        }
    } else {
        renderizarMaletinJuego();
    }
    
    if (errores == NUMERO_ERRORES_FIN) {
        // Poner game over.
    }
    
    if (microjuegos.get(0).obtenerTermino() &&
        microjuegos.get(1).obtenerTermino() &&
        microjuegos.get(2).obtenerTermino() /*&&
        microjuegos.get(3).obtenerTermino()*/) {
        // AGREGAR FIN DEL JUEGO EXITOSO.
    }
}

/*****************************************************/

/**
 * @brief Dibuja en pantalla el maletín que le permite al usuario seleccionar el microjuego
 * que quiere intentar resolver.
 */
void renderizarMaletinJuego()
{
    translate(width/2, height/2, 0); //Ajusta todos los objetos al centro de la pantalla.
    //rotateY(PI/8);
    fill(255);
    box(width, height, 50);
    
    fill(0);
    translate(-width/2, -height/2, 0);
    line(width/2, 0, 100, width/2, height, 100);
    line(0, height/2, 100, width, height/2, 100);
}

/*****************************************************/

/**
 * @brief Actualiza el índice del microjuego seleccionado o pasa el evento al microjuego
 * actual.
 */
void procesarClickBomba()
{
    if (mostrarMicrojuego) {
        microjuegos.get(microjuegoActual).procesarClick();
    } else {
        if (mouseX >= 0 && mouseX < width/2) {
            if (mouseY >= 0 && mouseY < height/2) {
                microjuegoActual = 0;
            } else {
                microjuegoActual = 1;
            }
        } else {
            if (mouseY >= 0 && mouseY < height/2) {
                microjuegoActual = 2;  // CAMBIAR YA QUE MÉTODOS DE CONTEO ESTÉ LISTO.
            } else {
                microjuegoActual = 2;
            }
        }
        
        mostrarMicrojuego = true;
    }
}

/*****************************************************/