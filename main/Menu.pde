/*
 * Este archivo contiene las funciones que despliegan el menú principal del juego al
 * usuario.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 15/Mayo/2017.
 */

/*****************************************************/

PImage botonIniciar, botonAcerca, botonPuntuaciones, botonSalir;
int anchoBoton, alturaBoton, padding;

/*****************************************************/

/**
 * @brief Carga las imágenes de cada botón del menú e inicializa las medidas de los mismos.
 */
void crearBotones()
{
    botonAcerca = loadImage("./img/acercade.png");
    botonPuntuaciones = loadImage("./img/puntuaciones.png");
    botonSalir = loadImage("./img/salir.png");
    botonIniciar = loadImage("./img/iniciar.png");

    anchoBoton = width/3;
    alturaBoton = height/8;
    padding = alturaBoton/10;
}

/*****************************************************/

/**
 * @brief Pinta en pantalla el menú principal.
 */
void desplegarMenu()
{
    dibujarFondo();
    
    textAlign(CENTER);
    textSize(MAGNITUD_TEXTO);
    text("Keep Hacking and Nobody Explodes", width/2, height/4);

    image(botonIniciar, width/2 - anchoBoton/2, height/2 - alturaBoton/2, anchoBoton, alturaBoton);
    image(botonAcerca, width/2 - anchoBoton/2, height/2 + alturaBoton/2 + padding, anchoBoton, alturaBoton);
    image(botonPuntuaciones, width/2 - anchoBoton/2, height/2 + 3*alturaBoton/2 + padding, anchoBoton, alturaBoton);
    image(botonSalir, width/2 - anchoBoton/2, height/2 + 5*alturaBoton/2 + padding, anchoBoton, alturaBoton);
}

/*****************************************************/

/**
 * @brief Revisa que botón oprimió el usuario y actúa acorde a ello.
 */
void procesarClickMenu()
{
    if (mouseX >= width/2 - anchoBoton/2 && mouseX <= width/2 + anchoBoton/2) {
        // Iniciar.
        if (mouseY >= height/2 - alturaBoton/2 && mouseY <= height/2 + alturaBoton/2) {
            muestraMenu = false;
            muestraJuego = true;
            
            microjuegos = new ArrayList<Microjuego>();
            microjuegos.add(new Cipher());
            microjuegos.add(new PaseoEuler());
            microjuegos.add(new MetodosConteo());
            microjuegos.add(new Discos());
            
            maletinJuego = createGraphics(width, height, P3D);
        // Acerca de.
        } else if (mouseY >= height/2 + alturaBoton/2 + padding && 
                   mouseY < height/2 + 3*alturaBoton/2 + padding) {
            muestraAcerca = true;
            muestraMenu = false;
        // Puntuaciones.
        } else if (mouseY >= height/2 + 3*alturaBoton/2 + padding && 
                   mouseY < height/2 + 5*alturaBoton/2 + padding) {
            muestraPuntaje = true;
            muestraMenu = false;
        // Salir.
        } else if (mouseY >= height/2 + 5*alturaBoton/2 + padding && 
                   mouseY < height/2 + 7*alturaBoton/2 + padding) {
            exit();
        }
    }
}

/*****************************************************/

/**
 * @brief Muestra en pantalla información sobre KHANE.
 */
void desplegarAcercaDe()
{
    int it;
    
    dibujarFondo();
    
    textAlign(CENTER);
    textSize(MAGNITUD_TEXTO);
    
    it = 0;
    for (String l : informacion) {
        text(l, width/2, height/4 + it*MAGNITUD_TEXTO);
        it++;
    }
}

/*****************************************************/