import java.lang.StringBuilder;
/*
 * Este archivo contiene las funciones que despliegan el juego actual de KHANE.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 19/Mayo/2017.
 */

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
            //reemplazar en caso de poner alguna animacion de explocion
            text("Perdiste...", width/2, height/2);
        }

        text("Tu puntaje fue: " + puntaje, width/2, height/2 + 50);
    } else if (!fade) {
        if (mostrarMicrojuego) {

            microjuegos.get(microjuegoActual).actualizar();
            //Calcula y dibuja el tiempo
            relojPrincipal.calcularTiempo();
            relojPrincipal.dibujarRelojDigital();
            

            if (microjuegos.get(microjuegoActual).obtenerFallo()) {
                ++errores;
            }
        } else {
            renderizarMaletinJuego();
            //Calcula y dibuja el tiempo
            relojPrincipal.calcularTiempo();
            relojPrincipal.dibujarRelojAnalogico();
            fill(255,0,0);
            text("Srl: " + serial, width/2, height/2 + 50);
        }

        if (errores == NUMERO_ERRORES_FIN) {
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
            fadeToBlack();
            fill(#B6D315);
            rect(width/2-150, height/2-50, 300, 60);
            fill(0);
            textFont(fuenteTextoDefault, 48);
            text("Ingresando", width/2, height/2 - 10); // -10 es para que quepa mejor el texto en el cuadro
            maletinJuego.background(intensidadFondo);
        } else {
            fadeToWhite();
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
 * @brief Funcion que crea el efecto visual de transicion
 de malatin a microjuego
 */
void fadeToBlack()
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
 * @brief Funcion que crea el efecto visual de transicion
 de microjuego a maletin
 */
void fadeToWhite()
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
 * @brief Funcion que procesa el fin del juego, por
 * victoria o derrota    
 * @param exito Variable booleana que indica si el jugador
 * desactivo exitosamente la bomba o no
 */
void procesarGameOver(boolean exito)
{
    //detenerReloj()

    puntaje = (int)(obtenerPuntaje());
    puntaje = 10000; //para prueba
    //String nombre;

    if (exito) {
        int i = 0;
        for (int punt : valoresPuntuaciones) {
            if (puntaje < punt) {
                ++i;
            }
        }
        
        if (i < valoresPuntuaciones.size()) {
            
          
            for (int j = valoresPuntuaciones.size() - 1; j > i; --j) {
                valoresPuntuaciones.set(j, valoresPuntuaciones.get(j - 1));
            }
            
            for (int j = nombresPuntuaciones.size() - 1; j > i; --j) {
                nombresPuntuaciones.set(j, nombresPuntuaciones.get(j - 1));
            }

            //nombre = valorIngresado;
            valoresPuntuaciones.set(i, (int)(puntaje));
            nombresPuntuaciones.set(i, valorIngresado);
            actualizarArchivoPuntuaciones();
            
        }
    }
}

/*****************************************************/

void resetearJuego()
{
    
    mostrarMicrojuego = false;
    terminoJuego = false;
    exito = false;
    microjuegoActual = 0;
    errores = 0;
    fade = false;
    puntaje = 0;
    muestraJuego = false;
    muestraMenu = true;
    valorIngresado = "CF";
    nomIngresado = false;
    microjuegos.clear();
}

/*****************************************************/

/**
 * @brief Funcion que calcula la puntuacion de los microjuegos
 * @return El puntaje total
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
String obtenerNombre()
{
    return valorIngresado;
}
/*****************************************************/
/**
 * @brief resta el ultimo digito del valor que el usuario lleva acumulado presionando teclas. i.e. 123456 -> 12345
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
 * @brief suma la tecla presionada al valor que el usuario lleva acumulado presionando teclas.
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