/*
 * Este archivo contiene todas las funciones necesarias para desplegar la pantalla de inicio
 * al usuario.
 *
 * Última modificación: 15/Mayo/2017.
 *
 * TODO:
 * - Arreglar iluminacion.
 * - Agregar partículas en la animación.
 * - Arreglar texturas.
 */

/*****************************************************/

private final int VALOR_MAX_COLOR = 255;
private PGraphics maletin, frenteMaletin, bomba, nombre, fondo;
private boolean mostrarAnimacionMenu = false;
private final float ROTACION_ESCENA_X = -PI/8.0;

/*****************************************************/

// Variables globales para la bomba.
// Todo lo que tenga 'B' es una variable para la bomba.
// Posición en el espacio de la bomba.
private int B_POS_X;
private float B_POS_Y;
private int B_POS_Z;

private final int MIN_ALPHA = 50;
private int B_MAGNITUD_CUERPO;
private final float B_VEL_ROTACION = 80.0;

private int B_MECHA_Y_OFFSET;
private final float B_MECHA_ANGULO_OFFSET = PI/2;
private final int B_MECHA_CANTIDAD_LADOS = 10;
private final int B_MECHA_RADIO = 20;
private float B_MECHA_VEL;
private float alturaMecha;

/*****************************************************/

// Variables goblales para el texto.
private float intensidadAlphaNombre = 255;
private float cambioAlpha = 5;
private boolean estaDesapareciendo = true;

private int T_POS_X;
private int T_Y_OFFSET;

/*****************************************************/

// Texturas para los objetos.
private PImage texturaExteriorMaletin;
private PImage texturaInteriorMaletin;
private PImage texturaBomba;
private PImage texturaMecha;
private PImage texturaChip;

/*****************************************************/

/**
 * @brief Inicializa los modelos para las figuras que serán renderizadas en 3D así como
 * constantes y texturas necesarias para los mismos.
 */
void crearModelos() {
    texturaExteriorMaletin = loadImage("./img/exterior_maletin.jpg");
    texturaInteriorMaletin = loadImage("./img/interior_maletin.jpg");
    texturaBomba = loadImage("./img/metal1.jpg");
    texturaMecha = loadImage("./img/mecha.jpg");
    texturaChip = loadImage("./img/chip.jpg");

    fondo = createGraphics(width, height, P3D);
    maletin = createGraphics(width, height, P3D);
    frenteMaletin = createGraphics(width, height, P3D);
    bomba = createGraphics(width, height, P3D);
    nombre = createGraphics(width, height, P2D);

    B_POS_X = width/2;
    B_POS_Y = height/2 - height/12;
    B_POS_Z = -110;

    B_MAGNITUD_CUERPO = 2 * height/7;

    B_MECHA_Y_OFFSET = -B_MAGNITUD_CUERPO;
    alturaMecha = height/3;
    B_MECHA_VEL = alturaMecha/50;

    T_POS_X = width/2;
    T_Y_OFFSET = height/10;
    
    mitad = new int[10];
    
    for (int i = 0; i < 10; i++) {
        mitad[i] = 0;
    }
    
    dibujarMaletin();
    dibujarFrenteMaletin();
}

/*****************************************************/

/**
 * @brief Dibuja todos los elementos necesarios para desplegar la pantalla de inicio del juego.
 */
void desplegarVentanaComienzo()
{   
    lightFalloff(1, 1, 2);
    lightSpecular(50, 0, 200);
    directionalLight(200, 200, 200, 0, 0, -1);
    ambientLight(128, 128, 128);

    dibujarFondo();
    dibujarNombre();
    //dibujarMaletin();
    tint(VALOR_MAX_COLOR, 255);
    image(maletin, 0, 0);
    dibujarBomba();
    //dibujarFrenteMaletin();
    tint(VALOR_MAX_COLOR, 255);
    image(frenteMaletin, 0, 0);

    // Avisa a la función principal cuando es momento de mostrar el menú principal.
    if (alturaMecha <= 0) {
        muestraInicio = false;
        muestraMenu = true;
    }
}

/*****************************************************/

int mitad[];

/**
 * @brief Renderiza un efecto visual en el fondo de la escena.
 */
void dibujarFondo()
{
    fondo.beginDraw();
    fondo.background(0);
    fondo.stroke(255);
    
    for (int i = 0; i < 10; i++) {
        fondo.line(0, i*height/10, 0, mitad[i], i*height/10, 0);
        
        fondo.beginShape();   
        fondo.texture(texturaChip);
        
        fondo.vertex(mitad[i], i*height/10 - height/40, 0, mitad[i], i*height/10 - height/40);
        fondo.vertex(mitad[i] + 50, i*height/10 - height/40, 0, mitad[i] + 50, i*height/10 - height/40);
        fondo.vertex(mitad[i] + 50, i*height/10 + height/40, 0, mitad[i] + 50, i*height/10 + height/40);
        fondo.vertex(mitad[i], i*height/10 + height/40, 0, mitad[i], i*height/10 + height/40);
        
        fondo.endShape(CLOSE);
        
        fondo.line(mitad[i] + 50, i*height/10, 0, width, i*height/10, 0);
    }
    fondo.endDraw();
    
    image(fondo, 0, 0);
    
    for (int i = 0; i < 10; i++) {
        if (mitad[i] < width) {
            mitad[i] += (int)(random(1, 20));
        } else {
            mitad[i] = 0;
        }
    }
}

/*****************************************************/

/**
 * @brief Dibuja el maletín que contiene a la bomba.
 */
void dibujarMaletin()
{
    maletin.beginDraw();

    maletin.lights();
    maletin.clear();

    maletin.rotateX(ROTACION_ESCENA_X);

    // Suelo del maletin.
    maletin.translate(width/2, height/2 + height/2.4 + height/12, -110 - width/3);

    maletin.beginShape();
    maletin.texture(texturaInteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(4*width/5 + width/12)/2, -(width/35.0)/2, -(2*width/3)/2, -(4*width/5 + width/12)/2, -(2*width/3)/2);
    maletin.vertex((4*width/5 + width/12)/2, -(width/35.0)/2, -(2*width/3)/2, (4*width/5 + width/12)/2, -(2*width/3)/2);
    maletin.vertex((4*width/5 + width/12)/2, -(width/35.0)/2, (2*width/3)/2, (4*width/5 + width/12)/2, (2*width/3)/2);
    maletin.vertex(-(4*width/5 + width/12)/2, -(width/35.0)/2, (2*width/3)/2, -(4*width/5 + width/12)/2, (2*width/3)/2);

    maletin.endShape(CLOSE);

    // Lados inferiores del maletin.
    // Lado izquiero.
    maletin.translate(-width/2 + width/14.0, -height/10, 0);

    maletin.beginShape();
    maletin.texture(texturaExteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(width/35.0)/2, -(height/4)/2, (2*width/3)/2, -(width/35.0)/2, (2*width/3)/2);
    maletin.vertex(-(width/35.0)/2, -(height/4)/2, -(2*width/3)/2, -(width/35.0)/2, -(2*width/3)/2);
    maletin.vertex((width/35.0)/2, -(height/4)/2, -(2*width/3)/2, (width/35.0)/2, -(2*width/3)/2);
    maletin.vertex((width/35.0)/2, -(height/4)/2, (2*width/3)/2, (width/35.0)/2, (2*width/3)/2);

    maletin.endShape(CLOSE);

    maletin.beginShape();
    maletin.texture(texturaInteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex((width/35.0)/2, -(height/4)/2, -(2*width/3)/2, -(height/4)/2, -(2*width/3)/2);
    maletin.vertex((width/35.0)/2, (height/4)/2, -(2*width/3)/2, (height/4)/2, -(2*width/3)/2);
    maletin.vertex((width/35.0)/2, (height/4)/2, (2*width/3)/2, (height/4)/2, (2*width/3)/2);
    maletin.vertex((width/35.0)/2, -(height/4)/2, (2*width/3)/2, -(height/4)/2, (2*width/3)/2);

    maletin.endShape(CLOSE);

    // Lado derecho.
    maletin.translate(2*(width/2 - width/14.0), 0, 0);

    maletin.beginShape();
    maletin.texture(texturaExteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex((width/35.0)/2, -(height/4)/2, (2*width/3)/2, (width/35.0)/2, (2*width/3)/2);
    maletin.vertex((width/35.0)/2, -(height/4)/2, -(2*width/3)/2, (width/35.0)/2, -(2*width/3)/2);
    maletin.vertex(-(width/35.0)/2, -(height/4)/2, -(2*width/3)/2, -(width/35.0)/2, -(2*width/3)/2);
    maletin.vertex(-(width/35.0)/2, -(height/4)/2, (2*width/3)/2, -(width/35.0)/2, (2*width/3)/2);

    maletin.endShape(CLOSE);

    maletin.beginShape();
    maletin.texture(texturaInteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(width/35.0)/2, -(height/4)/2, -(2*width/3)/2, -(height/4)/2, -(2*width/3)/2);
    maletin.vertex(-(width/35.0)/2, (height/4)/2, -(2*width/3)/2, (height/4)/2, -(2*width/3)/2);
    maletin.vertex(-(width/35.0)/2, (height/4)/2, (2*width/3)/2, (height/4)/2, (2*width/3)/2);
    maletin.vertex(-(width/35.0)/2, -(height/4)/2, (2*width/3)/2, -(height/4)/2, (2*width/3)/2);

    maletin.endShape(CLOSE);

    // Lado trasero.
    maletin.translate(-(width/2 - width/14.0), 0, -width/3);

    maletin.beginShape();
    maletin.texture(texturaExteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(4*width/5 + width/12)/2, -(height/4)/2, (width/35.0)/2, -(4*width/5 + width/12)/2, (width/35.0)/2);
    maletin.vertex(-(4*width/5 + width/12)/2, -(height/4)/2, -(width/35.0)/2, -(4*width/5 + width/12)/2, -(width/35.0)/2);
    maletin.vertex((4*width/5 + width/12)/2, -(height/4)/2, -(width/35.0)/2, (4*width/5 + width/12)/2, -(width/35.0)/2);
    maletin.vertex((4*width/5 + width/12)/2, -(height/4)/2, (width/35.0)/2, (4*width/5 + width/12)/2, (width/35.0)/2);

    maletin.endShape(CLOSE);

    maletin.beginShape();
    maletin.texture(texturaInteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(4*width/5 + width/12)/2, -(height/4)/2, (width/35.0)/2, -(4*width/5 + width/12)/2, -(height/4)/2);
    maletin.vertex((4*width/5 + width/12)/2, -(height/4)/2, (width/35.0)/2, (4*width/5 + width/12)/2, -(height/4)/2);
    maletin.vertex((4*width/5 + width/12)/2, (height/4)/2, (width/35.0)/2, (4*width/5 + width/12)/2, (height/4)/2);
    maletin.vertex(-(4*width/5 + width/12)/2, (height/4)/2, (width/35.0)/2, -(4*width/5 + width/12)/2, (height/4)/2);

    maletin.endShape(CLOSE);

    // Dibuja la parte superior del maletin.
    // Fondo.
    maletin.translate(10, -width/3 - width/17, -3 * width/35.0 - height/4);

    maletin.beginShape();
    maletin.texture(texturaInteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(4*width/5 + width/12)/2, -(2*width/3)/2, (width/35.0)/2, -(4*width/5 + width/12)/2, -(2*width/3)/2);
    maletin.vertex((4*width/5 + width/12)/2, -(2*width/3)/2, (width/35.0)/2, (4*width/5 + width/12)/2, -(2*width/3)/2);
    maletin.vertex((4*width/5 + width/12)/2, (2*width/3)/2, (width/35.0)/2, (4*width/5 + width/12)/2, (2*width/3)/2);
    maletin.vertex(-(4*width/5 + width/12)/2, (2*width/3)/2, (width/35.0)/2, -(4*width/5 + width/12)/2, (2*width/3)/2);

    maletin.endShape(CLOSE);

    // Lado izquierdo.
    maletin.translate(-(4*width/5 + width/12)/2, 0, height/4);

    maletin.beginShape();
    maletin.texture(texturaExteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(width/35.0)/2, -(2*width/3)/2, (height/4)/2, -(width/35.0)/2, -(2*width/3)/2);
    maletin.vertex((width/35.0)/2, -(2*width/3)/2, (height/4)/2, (width/35.0)/2, -(2*width/3)/2);
    maletin.vertex((width/35.0)/2, (2*width/3)/2, (height/4)/2, (width/35.0)/2, (2*width/3)/2);
    maletin.vertex(-(width/35.0)/2, (2*width/3)/2, (height/4)/2, -(width/35.0)/2, (2*width/3)/2);

    maletin.endShape(CLOSE);

    maletin.beginShape();
    maletin.texture(texturaInteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex((width/35.0)/2, -(2*width/3)/2, (height/4)/2, -(2*width/3)/2, (height/4)/2);
    maletin.vertex((width/35.0)/2, -(2*width/3)/2, -(height/4)/2, -(2*width/3)/2, -(height/4)/2);
    maletin.vertex((width/35.0)/2, (2*width/3)/2, -(height/4)/2, (2*width/3)/2, -(height/4)/2);
    maletin.vertex((width/35.0)/2, (2*width/3)/2, (height/4)/2, (2*width/3)/2, (height/4)/2);

    maletin.endShape(CLOSE);

    // Lado derecho.
    maletin.translate((4*width/5 + width/12) - 20, 0, 0);

    maletin.beginShape();
    maletin.texture(texturaExteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(width/35.0)/2, -(2*width/3)/2, (height/4)/2, -(width/35.0)/2, -(2*width/3)/2);
    maletin.vertex((width/35.0)/2, -(2*width/3)/2, (height/4)/2, (width/35.0)/2, -(2*width/3)/2);
    maletin.vertex((width/35.0)/2, (2*width/3)/2, (height/4)/2, (width/35.0)/2, (2*width/3)/2);
    maletin.vertex(-(width/35.0)/2, (2*width/3)/2, (height/4)/2, -(width/35.0)/2, (2*width/3)/2);

    maletin.endShape(CLOSE);

    maletin.beginShape();
    maletin.texture(texturaInteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(width/35.0)/2, -(2*width/3)/2, (height/4)/2, -(2*width/3)/2, (height/4)/2);
    maletin.vertex(-(width/35.0)/2, -(2*width/3)/2, -(height/4)/2, -(2*width/3)/2, -(height/4)/2);
    maletin.vertex(-(width/35.0)/2, (2*width/3)/2, -(height/4)/2, (2*width/3)/2, -(height/4)/2);
    maletin.vertex(-(width/35.0)/2, (2*width/3)/2, (height/4)/2, (2*width/3)/2, (height/4)/2);

    maletin.endShape(CLOSE);

    // Lado inferior.
    maletin.translate(-((4*width/5 + width/12))/2 + 10, width/3 - width/70.0, 0);

    maletin.beginShape();
    maletin.texture(texturaExteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(4*width/5 + width/12 - width/35.0 - 20)/2, (width/35.0)/2, (height/4)/2, -(4*width/5 + width/12 - width/35.0 - 20)/2, (width/35.0)/2);
    maletin.vertex(-(4*width/5 + width/12 - width/35.0 - 20)/2, -(width/35.0)/2, (height/4)/2, -(4*width/5 + width/12 - width/35.0 - 20)/2, -(width/35.0)/2);
    maletin.vertex((4*width/5 + width/12 - width/35.0 - 20)/2, -(width/35.0)/2, (height/4)/2, (4*width/5 + width/12 - width/35.0 - 20)/2, -(width/35.0)/2);
    maletin.vertex((4*width/5 + width/12 - width/35.0 - 20)/2, (width/35.0)/2, (height/4)/2, (4*width/5 + width/12 - width/35.0 - 20)/2, (width/35.0)/2);

    maletin.endShape(CLOSE);

    maletin.beginShape();
    maletin.texture(texturaInteriorMaletin);
    maletin.textureWrap(REPEAT);

    maletin.vertex(-(4*width/5 + width/12 - width/35.0 - 20)/2, -(width/35.0)/2, (height/4)/2, -(4*width/5 + width/12 - width/35.0 - 20)/2, (height/4)/2);
    maletin.vertex(-(4*width/5 + width/12 - width/35.0 - 20)/2, -(width/35.0)/2, -(height/4)/2, -(4*width/5 + width/12 - width/35.0 - 20)/2, -(height/4)/2);
    maletin.vertex((4*width/5 + width/12 - width/35.0 - 20)/2, -(width/35.0)/2, -(height/4)/2, (4*width/5 + width/12 - width/35.0 - 20)/2, -(height/4)/2);
    maletin.vertex((4*width/5 + width/12 - width/35.0 - 20)/2, -(width/35.0)/2, (height/4)/2, (4*width/5 + width/12 - width/35.0 - 20)/2, (height/4)/2);

    maletin.endShape(CLOSE);

    maletin.endDraw();

    //tint(VALOR_MAX_COLOR, 255);
    //image(maletin, 0, 0);
}

/*****************************************************/

/**
 * @brief Dibuja el maletín que contiene a la bomba.
 */
void dibujarFrenteMaletin()
{
    frenteMaletin.beginDraw();

    frenteMaletin.clear();

    frenteMaletin.rotateX(ROTACION_ESCENA_X);
    frenteMaletin.translate(width/2, height/2 + height/2.4, -110);

    // Parte frontal de la solapa.
    frenteMaletin.beginShape();
    frenteMaletin.texture(texturaExteriorMaletin);

    frenteMaletin.vertex(-(4*width/5 + width/9)/2, -(height/4)/2, width/70.0, -(4*width/5 + width/9)/2, -(height/4)/2);
    frenteMaletin.vertex((4*width/5 + width/9)/2, -(height/4)/2, width/70.0, (4*width/5 + width/9)/2, -(height/4)/2);
    frenteMaletin.vertex((4*width/5 + width/9)/2, (height/4)/2, width/70.0, (4*width/5 + width/9)/2, (height/4)/2);
    frenteMaletin.vertex(-(4*width/5 + width/9)/2, (height/4)/2, width/70.0, -(4*width/5 + width/9)/2, (height/4)/2);

    frenteMaletin.endShape(CLOSE);

    // Parte superior de la solapa.
    frenteMaletin.beginShape();
    frenteMaletin.texture(texturaExteriorMaletin);

    frenteMaletin.vertex(-(4*width/5 + width/9)/2, -(height/4)/2, width/70.0, -(4*width/5 + width/9)/2, width/70.0);
    frenteMaletin.vertex(-(4*width/5 + width/9)/2, -(height/4)/2, -width/70.0, -(4*width/5 + width/9)/2, -width/70.0);
    frenteMaletin.vertex((4*width/5 + width/9)/2, -(height/4)/2, -width/70.0, (4*width/5 + width/9)/2, -width/70.0);
    frenteMaletin.vertex((4*width/5 + width/9)/2, -(height/4)/2, width/70.0, (4*width/5 + width/9)/2, width/70.0);

    frenteMaletin.endShape(CLOSE);

    frenteMaletin.endDraw();

    //tint(VALOR_MAX_COLOR, 255);
    //image(maletin, 0, 0);
}

/*****************************************************/

/**
 * @brief Dibuja la bomba y su mecha.
 */
void dibujarBomba()
{
    float alpha;

    bomba.beginDraw();

    bomba.clear();

    // Empieza la animacion para desplegar el menu principal.
    if (mostrarAnimacionMenu) {
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

    nombre.lights();

    nombre.textAlign(CENTER);
    nombre.textFont(fuenteTextoDefault);
    nombre.textSize(MAGNITUD_TEXTO);
    // Dibuja el texto como gráficos de vector.
    nombre.textMode(SHAPE);

    // Deja de renderizar el texto durante la animación para mostrar el menú principal.
    if (mostrarAnimacionMenu) {
        nombre.background(0);
        nombre.endDraw();

        estaDesapareciendo = false;
    } else {
        nombre.text("Keep Hacking and Nobody Explodes", T_POS_X, height - 1.5*T_Y_OFFSET);
        nombre.text("Presiona cualquier botón del raton para comenzar", T_POS_X, height - T_Y_OFFSET);
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

    bomba.texture(texturaMecha);
    bomba.textureWrap(REPEAT);

    for (int i = 0; i < lados; i++) {
        x = cos(radians(i * angulo)) * r;
        y = sin(radians(i * angulo)) * r;
        bomba.vertex(x, y, -alturaMecha, x, y);
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

    bomba.beginShape();

    bomba.texture(texturaMecha);
    bomba.textureWrap(REPEAT);

    // Conecta ambas bases de la mecha.
    for (int i = 0; i < lados + 1; i++) {
        x = cos(radians(i * angulo)) * r;
        y = sin(radians(i * angulo)) * r;
        bomba.vertex(x, y, mitadAltura, x, y);
        bomba.vertex(x, y, -mitadAltura, x, y);
    }

    bomba.endShape(CLOSE);
}  

/*****************************************************/