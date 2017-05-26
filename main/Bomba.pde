/*
 * Este archivo contiene las funciones que despliegan el juego actual de KHANE.
 *
 * Autor: Spybots.
 * Ultima modificacion: 25/Mayo/2017.
 */

/*****************************************************/

import java.lang.StringBuilder;

/*****************************************************/

PGraphics maletinJuego;
boolean mostrarMicrojuego = false, terminoJuego = false, exito;
short microjuegoActual = 0, errores = 0;
final short NUMERO_ERRORES_FIN = 3; // Número de errores para Game Over.
boolean fade = false;
int intensidadFondo = 255, puntaje;
String valorIngresado = "XD";
boolean nomIngresado = false;

/*****************************************************/

PImage discosNoConcluidos, discosConcluidos;
PImage abacoConcluido, abacoNoConcluido;
PImage eulerNoCompletado, eulerCompletado;
PImage cipherNoConcluido, cipherConcluido;

/*****************************************************/

/**
 * @brief Actualiza el estado actual del microjuego que está jugando el usuario o del
 * maletín para seleccionar el nivel.
 */
void actualizarJuego()
{
    if (terminoJuego) {
        fill(255);
        textFont(fuenteTextoDefault, MAGNITUD_TEXTO);
        textAlign(CENTER);

        if (exito) {
            text("¡FELICIDADES!", width/2, height/2);
            text("Ingresa tu nombre: "+ valorIngresado, width/2, (height/2)+150);
        } else {
            text("Perdiste...", width/2, height/2);
        }

        text("Tu puntaje fue: " + puntaje, width/2, height/2 + 50);
    } else if (!fade) {
        if (mostrarMicrojuego) {

            microjuegos.get(microjuegoActual).actualizar();
            // Calcula y dibuja el tiempo.
            relojPrincipal.calcularTiempo();
            relojPrincipal.dibujarRelojDigital();
            

            if (microjuegos.get(microjuegoActual).obtenerFallo()) {
                ++errores;
            }
        } else {
            renderizarMaletinJuego();
            // Calcula y dibuja el tiempo.
            relojPrincipal.calcularTiempo();
            relojPrincipal.dibujarRelojAnalogico();
            if(serial > 50)
                fill(255);
            else
                fill(0);
            
            text("Srl: " + serial, width/2, height/2 + 50);
        }

        if (errores == NUMERO_ERRORES_FIN || relojPrincipal.obtenerTiempoMilis() >= 180000) {
            exito = false;
            terminoJuego = true;
            procesarGameOver(exito);
        }
        if (microjuegos.get(0).obtenerTermino() &&
            microjuegos.get(1).obtenerTermino() &&
            microjuegos.get(2).obtenerTermino() &&
            microjuegos.get(3).obtenerTermino()) {
            exito = true;
            terminoJuego = true;
            if(nomIngresado){  
                procesarGameOver(exito);
            }
        }
    } else {
        if (mostrarMicrojuego) {
            transicionNegro();
            fill(#B6D315);
            rect(width/2-150, height/2-50, 300, 60);
            fill(0);
            textFont(fuenteTextoDefault, 48);
            text("Ingresando", width/2, height/2 - 10); // -10 es para que quepa mejor el texto en el cuadro
            maletinJuego.background(intensidadFondo);
        } else {
            transicionBlanco();
            fill(#B6D315);
            rect(width/2-150, height/2-50, 300, 60);
            fill(0);
            textFont(fuenteTextoDefault, 48);
            text("Regresando", width/2, height/2 - 10); // -10 es para que quepa mejor el texto en el cuadro
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
    maletinJuego.fill(255);
    maletinJuego.box(width, height, 50);

    maletinJuego.fill(0);
    maletinJuego.translate(-width/2, -height/2, 0);
    maletinJuego.line(width/2, 0, 100, width/2, height, 100);
    maletinJuego.line(0, height/2, 100, width, height/2, 100);

    maletinJuego.endDraw();

    image(maletinJuego, 0, 0);
    
    // Despliega las imágenes que muestran el estado de cada microjuego.
    if (microjuegos.get(0).obtenerTermino()) {
        image(cipherConcluido, 0,0, width/2, height/2);
    } else {
        image(cipherNoConcluido, 0, 0, width/2, height/2);
    }
    
    if (microjuegos.get(2).obtenerTermino()) {
         image(abacoConcluido, width/2, 0, width/2, height/2);
    }else{
         image(abacoNoConcluido, width/2, 0, width/2, height/2);
    }
    
    if (microjuegos.get(1).obtenerTermino()) {
        image(eulerCompletado, 0, height/2, width/2, height/2);
    } else {
        image(eulerNoCompletado, 0, height/2, width/2, height/2);
    }
    
    if (microjuegos.get(3).obtenerTermino()) {
        image(discosConcluidos, width/2, height/2, width/2, height/2);
    } else {
        image(discosNoConcluidos, width/2, height/2, width/2, height/2);
    }
}

/*****************************************************/

/**
 * @brief Actualiza el índice del microjuego seleccionado o pasa el evento al microjuego
 * actual.
 */
void procesarClickBomba()
{
    if (terminoJuego) {
        // Reinicia todas las variables del juego para iniciar uno fresco y nuevo la siguiente
        // vez.
        resetearJuego();
    } else if (mostrarMicrojuego) {
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
    } else {
        if (key == TAB) {
            resetearJuego();
        }
    }
    
    if (exito) {
        switch(key) {
        case BACKSPACE:     
            restarValor(); 
            break;
        case ENTER: 
            nomIngresado = true;
            break;
        default:
            sumarValorIngresado(key);
            println(valorIngresado);
        }
    }
}

/*****************************************************/

/**
 * @brief Función que crea el efecto visual de transición
 * de maletín a microjuego.
 */
void transicionNegro()
{
    if (intensidadFondo < 5) {
        intensidadFondo= 0;
        fade = false;
    } else {
        intensidadFondo-=4;
    }
}
/*****************************************************/

/**
 * @brief Función que crea el efecto visual de transición
 * de microjuego a maletín.
 */
void transicionBlanco()
{
    if (intensidadFondo < 255) {
        intensidadFondo+=4;
    } else {
        intensidadFondo= 255;
        fade = false;
    }
}

/*****************************************************/

/**
 * @brief Función que procesa el fin del juego, por victoria o derrota.    
 * @param exito Variable booleana que indica si el jugador desactivó
 * exitosamente la bomba o no.
 */
void procesarGameOver(boolean exito)
{
    //detenerReloj()

    if (exito) {
        int i = 0;
        
        // Revisa si el puntaje actual del usuario queda dentro de los 10 mejores.
        for (int punt : valoresPuntuaciones) {
            if (puntaje < punt) {
                ++i;
            }
        }
        
        if (i < valoresPuntuaciones.size()) {
            // Se recorren los puntajes y nombres.
            for (int j = valoresPuntuaciones.size() - 1; j > i; --j) {
                valoresPuntuaciones.set(j, valoresPuntuaciones.get(j - 1));
            }
            
            for (int j = nombresPuntuaciones.size() - 1; j > i; --j) {
                nombresPuntuaciones.set(j, nombresPuntuaciones.get(j - 1));
            }

            valoresPuntuaciones.set(i, (int)(puntaje));
            nombresPuntuaciones.set(i, valorIngresado);
            actualizarArchivoPuntuaciones();
            
        }
    }
}

/*****************************************************/

/**
 * @brief Asigna valores predeterminados a todas las variables globales del juego para iniciar uno
 * nuevo la siguiente vez que el usuario ingrese.
 */
void resetearJuego()
{
    mostrarMicrojuego = false;
    terminoJuego = false;
    exito = false;
    fade = false;
    nomIngresado = false;
    
    // Borra los microjuegos que acaba de ver el usuario.
    microjuegoActual = 0;
    errores = 0;
    puntaje = 0;
    valorIngresado = "CF";
    microjuegos.clear();
    
    // Regresa el usuario al menú principal.
    muestraJuego = false;
    muestraMenu = true;
}

/*****************************************************/

/**
 * @brief Función que calcula la puntuación de los microjuegos.
 * @return El puntaje total del juego.
 */
double obtenerPuntaje()
{
    double puntaje = 0;
    for (Microjuego microjuego : microjuegos) {
        puntaje += microjuego.puntaje;
    }

    return puntaje;
}

/*****************************************************/

/**
 * @brief Resta el último dígito del valor que el usuario lleva acumulado
 * presionando teclas. i.e. 123456 -> 12345.
 */
void restarValor()
{
    if (valorIngresado.length() > 0) {
        StringBuilder sb = new StringBuilder(valorIngresado);
        sb.deleteCharAt(valorIngresado.length() - 1);
        valorIngresado = sb.toString();
    }
}
/*******************************************************/

/**
 * @brief Suma la tecla presionada al valor que el usuario lleva acumulado
 * presionando teclas.
 */
void sumarValorIngresado(char numAgregar)
{
    if (this.valorIngresado.length() < 5) {
        if (this.valorIngresado == "") {
            this.valorIngresado = str(numAgregar);
        } else {
            this.valorIngresado += numAgregar;
        }
    }
}