/*
 * Este archivo contiene las funciones que despliegan el juego actual de KHANE.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 19/Mayo/2017.
 */
 
/*****************************************************/

PGraphics maletinJuego;
boolean mostrarMicrojuego = false;
short microjuegoActual = 0, errores = 0;
final short NUMERO_ERRORES_FIN = 3; // Número de errores para Game Over.
boolean fade = false;
int intensidadFondo = 255;

/*****************************************************/

/**
 * @brief Actualiza el estado actual del microjuego que está jugando el usuario o del
 * maletín para seleccionar el nivel.
 */
void actualizarJuego()
{
    if(!fade){
        if (mostrarMicrojuego) {
                
            microjuegos.get(microjuegoActual).actualizar();
            
            if (microjuegos.get(microjuegoActual).obtenerFallo()) {
                errores++;
            }
        }else {
            renderizarMaletinJuego();
        }
        
        if (errores == NUMERO_ERRORES_FIN) {
            // Poner game over.
        }
        
        if (microjuegos.get(0).obtenerTermino() &&
            microjuegos.get(1).obtenerTermino() &&
            microjuegos.get(2).obtenerTermino() &&
            microjuegos.get(3).obtenerTermino()) {
            // AGREGAR FIN DEL JUEGO EXITOSO.
        }
    }else{
        if(mostrarMicrojuego){
            fadeToBlack();
            fill(#B6D315);
            rect(width/2-150, height/2-50, 300, 60);
            fill(0);
            textFont(fuenteTextoDefault, 48);
            text("Ingresando", 680, 375);
            maletinJuego.background(intensidadFondo);
        }else{
            fadeToWhite();
            fill(#B6D315);
            rect(width/2-150, height/2-50, 300, 60);
            fill(0);
            textFont(fuenteTextoDefault, 48);
            text("Regresando", 680, 375);
            maletinJuego.background(intensidadFondo);
        }
        
    }
}

/*****************************************************/

/**
 * @brief Dibuja en pantalla el maletín que le permite al usuario seleccionar el microjuego
 * que quiere intentar resolver.
 */
void renderizarMaletinJuego()
{
    maletinJuego.beginDraw();
    
    maletinJuego.translate(width/2, height/2, 0); //Ajusta todos los objetos al centro de la pantalla.
    //maletinJuego.rotateY(PI/12);
    maletinJuego.fill(255);
    maletinJuego.box(width, height, 50);
    
    maletinJuego.fill(0);
    maletinJuego.translate(-width/2, -height/2, 0);
    maletinJuego.line(width/2, 0, 100, width/2, height, 100);
    maletinJuego.line(0, height/2, 100, width, height/2, 100);
    
    maletinJuego.endDraw();
    
    image(maletinJuego, 0, 0);
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
            // No permite que el usuario visualice un microjuego que ya fue completado.
            if (mouseY >= 0 && mouseY < height/2 && !microjuegos.get(0).obtenerTermino()) {
                fade =true;
                microjuegoActual = 0;
                mostrarMicrojuego = true;
            }
            if (mouseY >= height/2 && mouseY < height && !microjuegos.get(1).obtenerTermino()) {
                fade =true;
                microjuegoActual = 1;
                mostrarMicrojuego = true;
            }
        } else {
            if (mouseY >= 0 && mouseY < height/2 && !microjuegos.get(2).obtenerTermino()) {
                fade =true;
                microjuegoActual = 2;
                mostrarMicrojuego = true;
            }
            if (mouseY >= height/2 && mouseY < height && !microjuegos.get(3).obtenerTermino()) {
                fade =true;
                microjuegoActual = 3;
                mostrarMicrojuego = true;
            }
        }
    }
}

/*****************************************************/

/**
 * @brief Manda a llamar la función del microjuego actual que se encarga de procesar
 * la tecla presionada por el usuario.
 */
void procesarTeclasBomba()
{
    if (mostrarMicrojuego) {
        if (key == TAB) {
            fade =true;
            mostrarMicrojuego = false;
        } else {
            microjuegos.get(microjuegoActual).procesarTeclas();
        }
    }
}

/*****************************************************/
/**
 * @brief Funcion que crea el efecto visual de transicion
 de malatin a microjuego
 */
void fadeToBlack()
{
    if(intensidadFondo < 5){
        intensidadFondo= 0;
        fade = false;
    }else{
        intensidadFondo-=4;
    }
}
/*****************************************************/
/**
 * @brief Funcion que crea el efecto visual de transicion
 de microjuego a maletin
 */
void fadeToWhite()
{
    if(intensidadFondo < 255){
        intensidadFondo+=4;
    }else{
        intensidadFondo= 255;
        fade = false;
    }
}