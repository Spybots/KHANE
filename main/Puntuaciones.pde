/*
 * Este archivo contiene las funciones que manejan a las puntuaciones de KHANE.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 23/Mayo/2017.
 */

/*****************************************************/

BufferedReader lectorPuntuaciones;

ArrayList<String> nombresPuntuaciones;
ArrayList<Integer> valoresPuntuaciones;

String linea;

/*****************************************************/

PrintWriter escritorPuntuaciones;

/*****************************************************/

void leerPuntuaciones()
{
    String auxValores[];
    
    nombresPuntuaciones = new ArrayList<String>();
    valoresPuntuaciones = new ArrayList<Integer>();
    
    // Consigue la información sobre las mejores puntuaciones.
    lectorPuntuaciones = createReader("./data/puntuaciones_nombres.khane");

    try {
        linea = lectorPuntuaciones.readLine();
        auxValores = split(linea, '*');
        
        int i = 0;
        for (String nombre : auxValores) {
            println("nombre: " + i + " " + nombre);
            nombresPuntuaciones.add(nombre);
            ++i;
        }
        
        println("Tam nombre: " + i);
        
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

        int i = 0;
        for (String valor : auxValores) {
            println("puntaje: " + i + " " + valor);
            valoresPuntuaciones.add(Integer.parseInt(valor));
            ++i;
        }
        
         println("Tam num: " + i);
    } catch (Exception exc) {
        println("7967789Ha ocurrido un error. Algunos archivos de KHANE pueden estar perdidos.");
    }
}

/*****************************************************/

void actualizarArchivoPuntuaciones() {
    try {
        escritorPuntuaciones = createWriter("./data/puntuaciones_nombres.khane");
        for (int i = 0; i < nombresPuntuaciones.size() - 1; i++) {
            escritorPuntuaciones.write(nombresPuntuaciones.get(i) + "*");
        }
        // Escribe el último nombre.
        escritorPuntuaciones.write(nombresPuntuaciones.get(nombresPuntuaciones.size() - 1));
        
        escritorPuntuaciones.close();
        
        escritorPuntuaciones = createWriter("./data/puntuaciones_valores.khane");
        for (int i = 0; i < valoresPuntuaciones.size() - 1; i++) {
            escritorPuntuaciones.write(valoresPuntuaciones.get(i) + "*");
        }
        // Escribe el último valor.
        escritorPuntuaciones.write(str(valoresPuntuaciones.get(valoresPuntuaciones.size() - 1)));
        
        escritorPuntuaciones.close();
        
        //leerPuntuaciones();
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