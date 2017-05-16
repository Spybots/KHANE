/*
 * Este archivo contiene la implementación de una clase auxiliar para el microjuego
 * de discos.
 *
 * Autor: Iván A. Moreno Soto.
 * Última modificación: 06/Mayo/2017.
 */

/*****************************************************/

/**
 * Esta clase define un número entero de longitud arbitraria y que está representado
 * con dígitos bajo un módulo arbitrario.
 */
class Numero {
    // Atributos de la clase.
    
    int modulo;
    int numeroDigitos;
    int[] digitos;
    
    /*****************************************************/
    
    /**
     * @brief Construye un Numero 0 con la cantidad de dígitos y el módulo indicados.
     *
     * @param modulo Módulo con el cual el número es representado.
     * @param numeroDigitos Número de digitos de longitud del número.
     */
    Numero(int modulo, int numeroDigitos)
    {
        this.modulo = modulo;
        this.numeroDigitos = numeroDigitos;
        this.digitos = new int[this.numeroDigitos];
        
        for (int d = 0; d < this.numeroDigitos; d++) {
            this.digitos[d] = 0;
        }
    }
    
    /*****************************************************/
    
    /**
     * @brief Construye un Numero con los dígitos y el módulo indicados. Se toma el módulo de
     * todos los dígitos dados.
     *
     * @param modulo Módulo con el cual el número es representado.
     * @param digitos Dígitos que formarán al número.
     */
    Numero(int modulo, int[] digitos)
    {
        this.modulo = modulo;
        this.numeroDigitos = digitos.length;
        this.digitos = new int[numeroDigitos];
        
        // Se pasa cada dígito dado al nuevo Número.
        for (int d = 0; d < numeroDigitos; d++) {
            this.digitos[d] = digitos[d] % modulo;
        }
    }
    
    /*****************************************************/
    
    /**
     * @brief Suma el Numero que llama a la función con otro Numero dado. Si el resultado de la suma da lugar a
     * un dígito extra, éste se ignora.
     *
     * @param a Segundo sumando. Debe tener el mismo módulo que la instancia que llama a esta función.
     *
     * @return Un nuevo Numero cuyos dígitos son la suma módulo this.modulo del Numero que llama a esta función y a.
     */
    Numero sumar(Numero a)
    {
        Numero resultado;
        int residuo; // Residuo que se lleva a la siguiente posición de la suma.
        
        resultado = new Numero(this.modulo, this.numeroDigitos);
        residuo = 0; //<>// //<>// //<>// //<>//
        
        for (int d = 0; d < resultado.numeroDigitos; d++) {
            resultado.digitos[d] = (this.digitos[d] + a.digitos[d] + residuo) % resultado.modulo; //<>// //<>// //<>// //<>//
            
            // Revisa si hubo residuo en la última suma.
            if (this.digitos[d] + a.digitos[d] + residuo >= resultado.modulo) { //<>// //<>// //<>// //<>//
                residuo = 1;
            } else {
                residuo = 0;
            }
        } //<>// //<>// //<>// //<>//
        
        return resultado;
    }
    
    /*****************************************************/
    
    /**
     * @brief Incrementa en una unidad la posición indicada de este Numero. Si hay un residuo,
     * sigue incrementando la siguiente posición.
     *
     * @param posicion Posicion del Numero que será incrementada.
     */
    void incrementar(int posicion)
    {
        if (posicion >= 0 && posicion <= this.numeroDigitos - 1) {
            if (this.digitos[posicion] < this.modulo - 1) { // Caso base.
                this.digitos[posicion]++;
            } else { // Cuando hay un residuo al incrementar.
                this.digitos[posicion] = 0;
                this.incrementar(posicion + 1);
            }
        }
    }
    
    /*****************************************************/
    
    /**
     * @brief Revisa si este Numero es 0.
     *
     * @return Verdadero si este Numero contiene 0 en todos sus dígitos, falso en otro caso.
     */
    boolean esCero() {
        boolean esCero;
        
        esCero = true;
        
        for (int d = 0; d < this.numeroDigitos && esCero; d++) {
            if (this.digitos[d] != 0) {
                esCero = false;
            }
        }
        
        return esCero;
    }
} // Fin de la clase Numero.

/*****************************************************/