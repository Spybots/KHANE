/*
 * Este archivo contiene las funciones principales de KHANE.
 *
 * Autor: Spybots.
 * Ultima modificacion: 25/Mayo/2017.
 */
 
 /*****************************************************/

PFont fuenteTextoDefault;
final int MAGNITUD_TEXTO = 48;

final int FPS_CAP = 60;

//Variables que indican que debe desplegar en pantalla.
boolean muestraInicio = true;
boolean muestraMenu = false;
boolean muestraJuego = false;
boolean muestraPuntaje = false;
boolean muestraAcerca = false;

// Variables globales sobre los microjuegos de KHANE.
final int NUMERO_MICROJUEGOS = 4; 
ArrayList<Microjuego> microjuegos;
Reloj relojPrincipal;
int serial;

BufferedReader lector;
String informacion[];

/*****************************************************/

/**
 * @brief Inicializa varios elementos del juego.
 */
void setup()
{
    String linea;
    
    fullScreen(P3D);
    frameRate(FPS_CAP);
    background(0, 0, 0);
    
    //Carga el texto usado por la interfaz del juego.
    fuenteTextoDefault = loadFont("./data/SertoKharput-48.vlw");
    textFont(fuenteTextoDefault, MAGNITUD_TEXTO); //<>// //<>//
    
    //Crea los modelos que seran usados en la pantalla de inicio.
    crearModelos();
    
    crearBotones();
    
    // Consigue la información sobre el software.
    lector = createReader("./data/acerca.khane");
    
    try {
        linea = lector.readLine();
        informacion = split(linea, '*');
        lector.close();
    } catch (Exception exc) {
        println("Ha ocurrido un error. Algunos archivos de KHANE pueden estar perdidos.");
    }
    
    leerPuntuaciones();
    
    discosNoConcluidos = loadImage("./img/discos_no_completo.png");
    discosConcluidos = loadImage("./img/discos_completo.png");

    abacoNoConcluido = loadImage("./img/portadaMetodosConteo.jpg");
    abacoConcluido = loadImage("/img/portadaMetodosConteoTerminado.jpg");
    
    eulerNoCompletado = loadImage("./img/eulerPathSAMPLE.png");
    eulerCompletado = loadImage("./img/eulerPathCompletedSAMPLE.png");
    
    cipherNoConcluido = loadImage("./img/cipher_no_completo.png");
    cipherConcluido = loadImage("./img/cipher_completo.png");
}

/*****************************************************/

/**
 * @brief Actualiza lo que el usuario ve en pantalla acorde al punto en el programa en el que esté. 
 */
void draw()
{
    // Fondo negro.
    background(0, 0, 0);
    
    if (muestraInicio) {
        desplegarVentanaComienzo();
    } else if (muestraMenu) {
        desplegarMenu();
    } else if (muestraJuego) {
        actualizarJuego();
    } else if (muestraPuntaje) {
        desplegarPuntuaciones();
    } else if (muestraAcerca) {
        desplegarAcercaDe();
    }
    
    // REMOVER DESPUES DE DEBUGUEAR.
    textSize(16);
    text("FPS: " + int(frameRate), 40, 20);
}

/*****************************************************/

/**
 * @brief Espera el click de un ratón para interactuar con el usuario.
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
        procesarClickPuntuaciones();
    } else if (muestraAcerca) {
        procesarClickAcerca();
    }
}

/*****************************************************/

/**
 * @brief Espera el evento de una tecla presionada. Sólo le importa el evento si el usuario
 * está dentro del juego.
 */
void keyPressed()
{   
    if (muestraJuego) {
        procesarTeclasBomba();
    }
}

/*****************************************************/