/*
 * Este archivo contiene todas las funciones necesarias para desplegar la pantalla de inicio
 * y el menú principal al usuario.
 *
 * Última modificación: 05/Mayo/2017.
 *
 * TODO:
 * - Arreglar iluminacion.
 * - Agregar partículas en la animación.
 * - Quitar numeros magicos.
 */
 
/*****************************************************/

private final int VALOR_MAX_COLOR = 255;
private PGraphics maletin, bomba, nombre;
private boolean mostrarMenu = false;
private final float ROTACION_ESCENA_X = -PI/8.0;

/*****************************************************/

// Todo lo que tenga 'M' es una variable para el maletín.

/*****************************************************/

// Todo lo que tenga 'B' es una variable para la bomba.
private final int B_SPOT_Z_OFFSET = 400; //Alejamiento de spotlight de la bomba.
private final int B_SPOT_INTENSIDAD = 8; //Intensidad de spotlight de la bomba.
private final float B_SPOT_ANGULO = PI/2;

// Posición en el espacio de la bomba.
private int B_POS_X;
private float B_POS_Y;
private int B_POS_Z;

private final int MIN_ALPHA = 50;
private int B_MAGNITUD_CUERPO;
private final float B_VEL_ROTACION = 80.0;

private int B_MECHA_Y_OFFSET;
private final float B_MECHA_ANGULO_OFFSET = PI/2;
private final int B_MECHA_CANTIDAD_LADOS = 30;
private final int B_MECHA_RADIO = 20;
private float B_MECHA_VEL;
private float alturaMecha;

/*****************************************************/

// Variables goblales para el texto.
private final int MAGNITUD_TEXTO = 32;
private float intensidadAlphaNombre = 255;
private float cambioAlpha = 5;
private boolean estaDesapareciendo = true;

/*****************************************************/

// Texturas para los objetos.
private PImage texturaMaletin;
private PImage texturaBomba;

/*****************************************************/

/**
 * @brief Inicializa los modelos para las figuras que serán renderizadas en 3D así como
 * constantes y texturas necesarias para los mismos.
 */
void crearModelos() {
    maletin = createGraphics(width, height, P3D);
    bomba = createGraphics(width, height, P3D);
    nombre = createGraphics(width, height, P2D);
    
    B_POS_X = width/2;
    B_POS_Y = height/2 - height/12;
    B_POS_Z = -110;
    
    B_MAGNITUD_CUERPO = 2 * height/7;
    
    B_MECHA_Y_OFFSET = -B_MAGNITUD_CUERPO;
    alturaMecha = height/3;
    B_MECHA_VEL = alturaMecha/50;
    
    texturaMaletin = loadImage("./img/red-skin640.jpg");
    texturaBomba = loadImage("./img/metal1.jpg");
}

/*****************************************************/

/**
 * @brief Espera el click de un ratón para iniciar la animación para desplegar el menú principal.
 */
void mouseClicked()
{
    if (!mostrarMenu) {
        mostrarMenu = true;
    }
}

/*****************************************************/

/**
 * @brief Dibuja todos los elementos necesarios para desplegar la pantalla de inicio del juego.
 */
void desplegarVentanaComienzo()
{
    dibujarFondo();
    dibujarNombre();
    dibujarMaletin();
    dibujarBomba();
    dibujarFrenteMaletin();
    
    
    // REMOVER DESPUES DE DEBUGUEAR.
    textSize(16);
    text("FPS: " + int(frameRate), 40, 20);
    
    
    // Avisa a la función principal cuando es momento de mostrar el menú principal.
    if (alturaMecha <= 0) {
        muestraInicio = false;
        muestraMenu = true;
    }   
}

/*****************************************************/

/**
 * @brief Renderiza un efecto visual en el fondo de la escena.
 */
void dibujarFondo()
{
    
}

/*****************************************************/

/**
 * @brief Dibuja el maletín que contiene a la bomba.
 */
void dibujarMaletin()
{
    maletin.beginDraw();
    
    maletin.texture(texturaMaletin);
    maletin.lights();
    maletin.clear();
    
    maletin.rotateX(ROTACION_ESCENA_X);
    
    // Suelo del maletin.
    maletin.translate(width/2, height/2 + height/2.4 + height/12, -110 - width/3);
    maletin.box(4*width/5 + width/12, width/35.0, 2*width/3);
    
    // Lados inferiores del maletin.
    // Lado izquiero.
    maletin.translate(-width/2 + width/14.0, -height/10, 0);
    maletin.box(width/35.0, height/4, 2*width/3);
    
    // Lado derecho.
    maletin.translate(2*(width/2 - width/14.0), 0, 0);
    maletin.box(width/35.0, height/4, 2*width/3);
    
    // Lado trasero.
    maletin.translate(-(width/2 - width/14.0), 0, -width/3);
    maletin.box(4*width/5 + width/12, height/4, width/35.0);
    
    // Dibuja la parte superior del maletin.
    // Fondo.
    maletin.translate(10, -width/3 - width/17, -3 * width/35.0 - height/4);
    maletin.box(4*width/5 + width/12, 2*width/3, width/35.0);
    
    // Lado izquierdo.
    maletin.translate(-(4*width/5 + width/12)/2, 0, height/4);
    maletin.box(width/35.0, 2*width/3, height/4);
    
    // Lado derecho.
    maletin.translate((4*width/5 + width/12) - 20, 0, 0);
    maletin.box(width/35.0, 2*width/3, height/4);
    
    // Lado inferior.
    maletin.translate(-((4*width/5 + width/12))/2 + 10, width/3 - width/70.0, 0);
    maletin.box(4*width/5 + width/12, width/35.0, height/4);
    
    maletin.endDraw();
    
    tint(VALOR_MAX_COLOR, 255);
    image(maletin, 0, 0);
}

/*****************************************************/

/**
 * @brief Dibuja el maletín que contiene a la bomba.
 */
void dibujarFrenteMaletin()
{
    maletin.beginDraw();
    
    maletin.texture(texturaMaletin);
    maletin.lights();
    maletin.clear();
    
    maletin.rotateX(ROTACION_ESCENA_X);
    maletin.translate(width/2, height/2 + height/2.4, -110);
    maletin.box(4*width/5 + width/9, height/4, width/35.0);
    
    maletin.endDraw();
    
    tint(VALOR_MAX_COLOR, 255);
    image(maletin, 0, 0);
}

/*****************************************************/

/**
 * @brief Dibuja la bomba y su mecha.
 */
void dibujarBomba()
{
    float alpha;
   
    bomba.beginDraw();
    
    bomba.lights();
    bomba.ambientLight(0, 0, VALOR_MAX_COLOR);
    bomba.directionalLight(0, VALOR_MAX_COLOR, VALOR_MAX_COLOR, -1, 0, -1);
    bomba.spotLight(VALOR_MAX_COLOR, 0, 0, width/2, height/2, B_SPOT_Z_OFFSET, 0, 0, -1, B_SPOT_ANGULO, B_SPOT_INTENSIDAD);
    
    bomba.clear();
    
    bomba.texture(texturaBomba);
    
    // Empieza la animacion para desplegar el menu principal.
    if (mostrarMenu) {
        // Reduce la mecha.
        if (alturaMecha > 0) {
            alturaMecha -= B_MECHA_VEL;
        }
        
        // Elimina el efecto de transparencia.
        alpha = VALOR_MAX_COLOR;
    } else {
        // Crea un efecto de transparencia respecto a la distancia al centro vertical de la bomba.
        alpha = map(abs(mouseY - height/2), height/2, 0, MIN_ALPHA, VALOR_MAX_COLOR);
    }
    
    // Posiciona la bomba.
    bomba.translate(B_POS_X, B_POS_Y, B_POS_Z);
    bomba.rotateX(ROTACION_ESCENA_X);
    bomba.rotateY(frameCount/B_VEL_ROTACION);
    
    bomba.sphere(B_MAGNITUD_CUERPO);
    
    // Dibuja la mecha.
    bomba.translate(0, B_MECHA_Y_OFFSET, 0);
    bomba.rotateX(B_MECHA_ANGULO_OFFSET);
    dibujarMecha(B_MECHA_CANTIDAD_LADOS, B_MECHA_RADIO, alturaMecha);
    
    bomba.endDraw();
    
    tint(VALOR_MAX_COLOR, alpha);
    image(bomba, 0, 0);
}

/*****************************************************/

/**
 * @brief Muestra el nombre del juego y una instrucción al usuario para iniciar el juego.
 */
void dibujarNombre()
{
    nombre.beginDraw();
    
    nombre.textAlign(CENTER);
    nombre.textSize(MAGNITUD_TEXTO);
    // Dibuja el texto como graficos de vector.
    nombre.textMode(SHAPE);
    
    // Deja de renderizar el texto durante la animación para mostrar el menú principal.
    if (mostrarMenu) {
        nombre.background(0);
        nombre.endDraw();
        
        estaDesapareciendo = false;
    } else {
        nombre.text("Keep Hacking and Nobody Explodes", width/2, height - height/10 - 48);
        nombre.text("Presiona cualquier boton del raton para comenzar", width/2, height - height/10);
        nombre.endDraw();
        
        // Crea la animación de aparición del texto.
        if (!estaDesapareciendo) {
            intensidadAlphaNombre += cambioAlpha;
        
            if (intensidadAlphaNombre >= VALOR_MAX_COLOR) {
                estaDesapareciendo = true;
            }
        } 
    }

    // Crea la animación de desaparición del texto.
    if (estaDesapareciendo) {
        intensidadAlphaNombre -= cambioAlpha;
        
        if (intensidadAlphaNombre <= 0) {
            estaDesapareciendo = false;
        }
    }
    
    tint(VALOR_MAX_COLOR, intensidadAlphaNombre);
    image(nombre, 0, 0);
}

/*****************************************************/

/**
 * @brief Dibuja la mecha de la bomba.
 * @param lados Número de lados para las bases de la mecha.
 * @param r Radio de las bases de la mecha.
 * @param h Altura de la mecha.
 */
void dibujarMecha(int lados, float r, float h)
{
    float angulo, mitadAltura, x, y;
    
    angulo = 360/lados;
    mitadAltura = h/2;
    
    // Dibuja la parte de arriba. 
    bomba.beginShape();
    
    for (int i = 0; i < lados; i++) {
        x = cos(radians(i * angulo)) * r;
        y = sin(radians(i * angulo)) * r;
        bomba.vertex(x, y, -alturaMecha);    
    }
    
    bomba.endShape(CLOSE);
    
    // Dibuja la parte de abajo.
    bomba.beginShape();
    
    for (int i = 0; i < lados; i++) {
        x = cos(radians(i * angulo)) * r;
        y = sin(radians(i * angulo)) * r;
        bomba.vertex(x, y, mitadAltura);    
    }
    
    bomba.endShape(CLOSE);
    
    bomba.beginShape(TRIANGLE_STRIP);
    
    // Conecta ambas bases de la mecha.
    for (int i = 0; i < lados + 1; i++) {
        x = cos(radians(i * angulo)) * r;
        y = sin(radians(i * angulo)) * r;
        bomba.vertex( x, y, mitadAltura);
        bomba.vertex( x, y, -mitadAltura);    
    }
    
    bomba.endShape(CLOSE); 
}  

/*****************************************************/
