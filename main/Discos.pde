/*
 * Este archivo contiene la implementación del microjuego de discos, donde se suman
 * vectores bajo cierto campo finito.
 *
 * Autor: Iván A. Moreno Soto.
 * Última modificación: 08/Mayo/2017.
 *
 * TODO:
 * - Iluminacion
 * - Texturas
 */

/*****************************************************/

private final int NUM_DIGITOS_DISCOS = 8;
private final int NUM_EXITOS_PARA_TERMINAR = 3;
private final int PUNTUACION_EXITO = 200;
private final int PENALIZACION_FALLO = -100;

/*****************************************************/

/**
 *
 */
class Discos extends Microjuego {
    // Atributos de la clase.
    int modulo, exitos, numeroFallos, intensidadFondo;
    boolean cambiarNivel, oscurecerFondo, animarFallo;
    Banda sumandoUno, sumandoDos, suma;
    PGraphics indicador;

    /*****************************************************/

    /**
     * @brief
     */
    Discos()
    {
        this.ID = 4;
        this.numeroFallos = 0;
        this.exitos = 0;
        this.intensidadFondo = 50;
        this.nombre = "Discos";
        this.termino = false;
        this.fallo = false;
        this.oscurecerFondo = true;
        this.puntaje = 0.0;
        this.cambiarNivel = false;
        this.animarFallo = false;
        
        this.sumandoUno = new Banda();
        this.sumandoDos = new Banda();
        this.suma = new Banda();

        this.indicador = createGraphics(width, height,  P3D);

        this.crearNivel();
    }

    /*****************************************************/

    /**
     * @brief
     */
    void crearNivel()
    {
        int digitos[], posicion;

        this.modulo = (int)(random(2, 5));

        // Genera al azar el primer vector.
        digitos = new int[NUM_DIGITOS_DISCOS];
        digitos[0] = (int)(random(1, modulo)); // Simplifica el microjuego evitando que el primer dígito sea 0.
        for (int d = 1; d < NUM_DIGITOS_DISCOS; d++) {
            digitos[d] = (int)(random(modulo));
        }

        // Crea dos Numeros que sumados dan 0 bajo el módulo de los mismos.
        this.sumandoUno.numero = new Numero(this.modulo, digitos);
        this.sumandoDos.numero = new Numero(this.modulo, NUM_DIGITOS_DISCOS);
        
        // Crea cada dígito del segundo sumando a partir del primero.
        this.sumandoDos.numero.digitos[0] = (this.modulo - this.sumandoUno.numero.digitos[0]) % this.modulo;
        for (int d = 1; d < NUM_DIGITOS_DISCOS; d++) {
            this.sumandoDos.numero.digitos[d] = this.modulo - this.sumandoUno.numero.digitos[d] - 1;
        }

        do {
            // Ahora modifica al azar un dígito del segundo sumando para crear el problema.
            posicion = (int)(random(this.sumandoDos.numero.numeroDigitos));
            if (this.sumandoDos.numero.digitos[posicion] > 0) {
                this.sumandoDos.numero.digitos[posicion]--;
            }
            
            // Obtiene la suma que será desplegada al jugador.
            this.suma.numero = this.sumandoUno.numero.sumar(this.sumandoDos.numero);
        } while(this.suma.numero.esCero());
    }

    /*****************************************************/

    /**
     * @brief
     */
    boolean obtenerFallo()
    {
        boolean valor;
        
        valor = this.fallo;
        
        if (this.fallo) {
            this.fallo = false;
        }
        
        return valor;
    }

    /*****************************************************/

    /**
     * @brief
     */
    boolean obtenerTermino()
    {   
        if (this.exitos == NUM_EXITOS_PARA_TERMINAR) {
            this.termino = true;
        } else {
            this.termino = false;
        }

        return this.termino;
    }

    /*****************************************************/

    /**
     * @brief
     */
    void calcularPuntaje()
    {
        this.puntaje = (PUNTUACION_EXITO * this.exitos) - (PENALIZACION_FALLO * this.numeroFallos);
    }

    /*****************************************************/

    void procesarClick()
    {
        float distanciaCentro, angulo;
        
        if (this.exitos < NUM_EXITOS_PARA_TERMINAR) {
            distanciaCentro = sqrt(sq(mouseX - width/2) + sq(mouseY - height/2));
            
            // Revisa que el click se haya realizado dentro de la zona del segundo sumando.
            if (distanciaCentro <= height/3 && distanciaCentro >= height/6) {
                angulo = atan2((mouseY - height/2), (mouseX - width/2));
                
                if (angulo > 0 && angulo < PI/4) {
                    this.sumandoDos.numero.incrementar(0);
                } else if (angulo > PI/4 && angulo < PI/2) {
                    this.sumandoDos.numero.incrementar(1);
                } else if (angulo > PI/2 && angulo < 3*PI/4) {
                    this.sumandoDos.numero.incrementar(2);
                } else if (angulo > 3*PI/4 && angulo < PI) {
                    this.sumandoDos.numero.incrementar(3);
                } else if (angulo < 0 && angulo > -PI/4) {
                    this.sumandoDos.numero.incrementar(7);
                } else if (angulo < -PI/4 && angulo > -PI/2) {
                    this.sumandoDos.numero.incrementar(6);
                } else if (angulo < -PI/2 && angulo > -3*PI/4) {
                    this.sumandoDos.numero.incrementar(5);
                } else if (angulo < -3*PI/4 && angulo > -PI) {
                    this.sumandoDos.numero.incrementar(4);
                } 
                
                this.suma.numero = this.sumandoUno.numero.sumar(this.sumandoDos.numero);
                
                if (this.suma.numero.esCero()) {
                    this.exitos++;
                    
                    if (this.exitos == NUM_EXITOS_PARA_TERMINAR) {
                        // Pone todos los números en 0.
                        this.sumandoUno.numero = new Numero(this.modulo, NUM_DIGITOS_DISCOS);
                        this.sumandoDos.numero = new Numero(this.modulo, NUM_DIGITOS_DISCOS);
                        this.suma.numero = new Numero(this.modulo, NUM_DIGITOS_DISCOS);
                    }
                } else {
                    this.fallo = true;
                    this.animarFallo = true;
                    this.numeroFallos++;
                    this.intensidadFondo = 0;
                }
                
                this.cambiarNivel = true;
            }
        }
    }

    /*****************************************************/

    /**
     * @brief
     */
    void actualizar()
    {
        this.crearFondo();

        if (this.cambiarNivel && this.exitos < NUM_EXITOS_PARA_TERMINAR) {
            this.crearNivel();
            this.cambiarNivel = false;
        }

        // Dibuja el indicador del módulo de los Numeros.
        this.dibujarIndicador();

        // Dibuja los discos con los Numeros y colores correspondientes.
        this.sumandoUno.dibujarBanda(width/2, height/2, -150, 30, height/2, height/3, 200);
        this.sumandoDos.dibujarBanda(width/2, height/2, -50, 30, height/3, height/6, 200);
        this.suma.dibujarBanda(width/2, height/2, 0, 30, height/6, 0, 150);
    }
    
    /*****************************************************/
    
    void dibujarIndicador()
    {
        float angulo, mitadAltura, x, y, h, r;
        int lados;
        
        lados = 30;
        h = 30;
        r = width/40;
        
        this.indicador.beginDraw();

        this.indicador.translate(width - width/20, width/20, 0);
        this.indicador.box(width/10, width/10, 10);
        
        this.indicador.fill(this.modulo * 50);

        angulo = 360/lados;
        mitadAltura = h/2;

        // Dibuja la parte de arriba. 
        this.indicador.beginShape();

        for (int i = 0; i < lados; i++) {
            x = cos(radians(i * angulo)) * r;
            y = sin(radians(i * angulo)) * r;
            this.indicador.vertex(x, y, -mitadAltura);
        }

        this.indicador.endShape(CLOSE);

        // Dibuja la parte de abajo.
        this.indicador.beginShape();

        for (int i = 0; i < lados; i++) {
            x = cos(radians(i * angulo)) * r;
            y = sin(radians(i * angulo)) * r;
            this.indicador.vertex(x, y, mitadAltura);
        }

        this.indicador.endShape(CLOSE);

        this.indicador.beginShape(TRIANGLE_STRIP);

        // Conecta ambas bases de la mecha.
        for (int i = 0; i < lados + 1; i++) {
            x = cos(radians(i * angulo)) * r;
            y = sin(radians(i * angulo)) * r;
            this.indicador.vertex( x, y, mitadAltura);
            this.indicador.vertex( x, y, -mitadAltura);
        }

        this.indicador.endShape(CLOSE);

        this.indicador.endDraw();

        image(this.indicador, 0, 0);
    }
    
    /*****************************************************/
    
    void crearFondo()
    {
        if (this.animarFallo) {
            this.intensidadFondo += 8;
            
            if (this.intensidadFondo >= 255) {
                this.animarFallo = false;
                this.intensidadFondo = 0;
            }
            
            background(this.intensidadFondo, 0, 0);
        } else if (this.oscurecerFondo) {
            this.intensidadFondo -= 2;
            
            if (this.intensidadFondo <= 0) {
                this.oscurecerFondo = false;
            }
            
            background(0, this.intensidadFondo, 0);
        } else {
            this.intensidadFondo += 1;
            
            if (this.intensidadFondo >= 80) {
                this.oscurecerFondo = true;
            }
            
            background(0, this.intensidadFondo, 0);
        }
    }
    
} // Fin de la clase Discos.

class Banda {
    // Atributos de la clase.
    Numero numero;
    PGraphics disco;
    
    Banda()
    {
        this.disco = createGraphics(width, height, P3D);
    }
    
    void dibujarBanda(float x, float y, float z, int lados, float R, float r, float h)
    {
        this.disco.beginDraw();
        
        this.disco.fill(255);
        this.disco.lights();
        this.disco.clear();
        
        this.disco.translate(x, y, z);
        this.dibujarDiscoExterno(lados, R, h);
        this.dibujarDiscoInterno(R, r, h);
        
        this.disco.endDraw();
        
        image(this.disco, 0, 0);
    }
    
    void dibujarDiscoExterno(int lados, float r, float h)
    {
        float angulo, mitadAltura, x, y;

        angulo = 360/lados;
        mitadAltura = h/2;

        // Dibuja la parte de arriba. 
        this.disco.beginShape();

        for (int i = 0; i < lados; i++) {
            x = cos(radians(i * angulo)) * r;
            y = sin(radians(i * angulo)) * r;
            this.disco.vertex(x, y, -mitadAltura);
        }

        this.disco.endShape(CLOSE);

        // Dibuja la parte de abajo.
        this.disco.beginShape();
        
        this.disco.texture(texturaBomba);
        this.disco.textureWrap(REPEAT);

        for (int i = 0; i < lados; i++) {
            x = cos(radians(i * angulo)) * r;
            y = sin(radians(i * angulo)) * r;
            this.disco.vertex(x, y, mitadAltura, x, y);
        }

        this.disco.endShape(CLOSE);

        this.disco.beginShape(TRIANGLE_STRIP);

        // Conecta ambas bases de la mecha.
        for (int i = 0; i < lados + 1; i++) {
            x = cos(radians(i * angulo)) * r;
            y = sin(radians(i * angulo)) * r;
            this.disco.vertex( x, y, mitadAltura);
            this.disco.vertex( x, y, -mitadAltura);
        }

        this.disco.endShape(CLOSE);
    }
    
    void dibujarDiscoInterno(float R, float r, float h)
    {
        int[] colores;
        float angulo, mitadAltura, x, y;

        angulo = 360/NUM_DIGITOS_DISCOS;
        mitadAltura = h/2;

        for (int i = 0; i < NUM_DIGITOS_DISCOS; i++) {
            this.disco.beginShape();

            colores = this.obtenerColorCelda(this.numero.digitos[i]);
            this.disco.fill(colores[0], colores[1], colores[2]);

            x = cos(radians(i * angulo)) * R;
            y = sin(radians(i * angulo)) * R;
            this.disco.vertex(x, y, mitadAltura);

            x = cos(radians((i + 1) * angulo)) * R;
            y = sin(radians((i + 1) * angulo)) * R;
            this.disco.vertex(x, y, mitadAltura);

            x = cos(radians((i + 1) * angulo)) * r;
            y = sin(radians((i + 1) * angulo)) * r;
            this.disco.vertex(x, y, mitadAltura);

            x = cos(radians(i * angulo)) * r;
            y = sin(radians(i * angulo)) * r;
            this.disco.vertex(x, y, mitadAltura);

            this.disco.endShape(CLOSE);

            this.disco.fill(255);
        }
    }
    
    int[] obtenerColorCelda(int digito) 
    {
        int[] colores = new int[3];
        
        if (digito == 0) {
            // Azul fuerte.
            colores[0] = 45;
            colores[1] = 86;
            colores[2] = 166;
        } else if (digito == 1) {
            // Naranja.
            colores[0] = 249;
            colores[1] = 144;
            colores[2] = 47;
        } else if (digito == 2) {
            // Azul verde.
            colores[0] = 50;
            colores[1] = 202;
            colores[2] = 202;
        } else if (digito == 3) {
            // Morado.
            colores[0] = 140;
            colores[1] = 65;
            colores[2] = 212;
        }
        
        return colores;
    }
} // Fin de la clase Banda.
/*****************************************************/