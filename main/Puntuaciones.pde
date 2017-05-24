/*
 * Este archivo contiene las funciones que manejan a las puntuaciones de KHANE.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 23/Mayo/2017.
 */

/*****************************************************/

BufferedReader lectorPuntuaciones;

String nombresPuntuaciones[];
int valoresPuntuaciones[];

String linea;

/*****************************************************/

PrintWriter escritorPuntuaciones;

/*****************************************************/

void leerPuntuaciones()
{
    int indice;
    String auxValores[];
    
    // Consigue la información sobre las mejores puntuaciones.
    lectorPuntuaciones = createReader("./data/puntuaciones_nombres.khane");

    try {
        linea = lectorPuntuaciones.readLine();
        nombresPuntuaciones = split(linea, '*');
        lectorPuntuaciones.close();
    } 
    catch (Exception exc) {
        println("Ha ocurrido un error. Algunos archivos de KHANE pueden estar perdidos.");
    }

    lectorPuntuaciones = createReader("./data/puntuaciones_valores.khane");

    try {
        linea = lectorPuntuaciones.readLine();
        auxValores = split(linea, '*');
        lectorPuntuaciones.close();

        indice = 0;
        valoresPuntuaciones = new int[10];
        for (String valor : auxValores) {
            valoresPuntuaciones[indice] = Integer.parseInt(valor);
            ++indice;
        }
    } catch (Exception exc) {
        println("Ha ocurrido un error. Algunos archivos de KHANE pueden estar perdidos.");
    }
}

/*****************************************************/

void actualizarArchivoPuntuaciones() {
    try {
        escritorPuntuaciones = createWriter("./data/puntuaciones_nombres.khane");
        for (String nombre : nombresPuntuaciones) {
            escritorPuntuaciones.write(nombre + "*");
        }
        
        escritorPuntuaciones.flush();
        escritorPuntuaciones.close();
        
        escritorPuntuaciones = createWriter("./data/puntuaciones_valores.khane");
        for (int valor : valoresPuntuaciones) {
            escritorPuntuaciones.write(valor + "*");
        }
        
        escritorPuntuaciones.flush();
        escritorPuntuaciones.close();
    } catch (Exception exc) {
        println("Ha ocurrido un error al actualizar las puntuaciones.");
    }
}

/*****************************************************/

void desplegarPuntuaciones()
{
    int it;

    dibujarFondo();

    textAlign(CENTER);
    textSize(MAGNITUD_TEXTO);

    it = 0;
    for (String l : nombresPuntuaciones) {
        text(l, width/2 - width/12, height/6 + it*MAGNITUD_TEXTO);
        it++;
    }

    it = 0;
    for (int l : valoresPuntuaciones) {
        text(l, width/2 + width/12, height/6 + it*MAGNITUD_TEXTO);
        it++;
    }

    image(botonRegresar, width/2 - anchoBoton/2, height - height/10 - alturaBoton/2, anchoBoton, alturaBoton);
}

/*****************************************************/

/**
 * @brief Revisa si el usuario hizo click en el botón "Regresar" e indica al programa que debe
 * desplegar nuevamente el menú principal.
 */
void procesarClickPuntuaciones()
{
    if (mouseX >= width/2 - anchoBoton/2 &&
        mouseX <= width/2 + anchoBoton/2 &&
        mouseY >= height - height/10 - alturaBoton/2 &&
        mouseY <= height - height/10 + alturaBoton/2) {
        muestraPuntaje = false;
        muestraMenu = true;
    }
}

/*****************************************************/