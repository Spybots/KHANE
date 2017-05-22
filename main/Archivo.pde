/*
 * Este archivo contiene las clases encargadas de leer y escribir información importante de KHANE.
 *
 * Autor: Iván A. Moreno Soto.
 * Ultima modificacion: 20/Mayo/2017.
 */

/*****************************************************/

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import java.io.FileInputStream;
import java.io.FileOutputStream;

import java.io.IOException;
import java.io.FileNotFoundException;

/*****************************************************/

/**
 * Esta clase se encarga de leer archivos binarios que contengan cadenas de caracteres.
 */
class LectorArchivo {
    // Atributos de la clase.
    /**
     * Flujo de entrada actual.
     */
    ObjectInputStream flujo;
    
    /*****************************************************/
    
    /**
     * @brief Abre un flujo de entrada con el archivo especificado.
     * 
     * @param nombre Nombre del archivo que se va a abrir.
     * @throws FileNotFoundException Si el archivo no se encuentra.
     * @throws IOException Si la operación de abertura falla.
     */
    void abrir(String nombre) throws FileNotFoundException, IOException
    {
        this.flujo = new ObjectInputStream(new FileInputStream(nombre));
    }
    
    /*****************************************************/
    
    /**
     * @brief Lee el contenido del archivo binario previamente abierto y devuelve su
     * contenido.
     * 
     * @return Caracteres contenidos en el archivo.
     * @throws IOException Si la lectura falla.
     * @throws ClassNotFoundException Si hay problemas con los caracteres leídos.
     */
    String leer() throws IOException, ClassNotFoundException
    {
        return (String)(flujo.readObject());
    }
    
    /*****************************************************/
    
    /**
     * @brief Cierra el flujo de entrada actual si está abierto.
     * 
     * @throws IOException Si la operación de cierre falla.
     */
    void cerrar() throws IOException
    {
        if (flujo != null) 
            flujo.close();
    }
    
    /*****************************************************/
} // Fin de la clase LectorArchivo.

/*****************************************************/

/**
 * Esta clase se encarga de guardar cadenas de caracteres en archivos que KHANE pueda utilizar después.
 */
public class EscritorArchivo {
    // Atributos de la clase.
    /**
     * Flujo de salida del escritor.
     */
    ObjectOutputStream flujo;
    
    /*****************************************************/
    
    /**
     * @brief Abre un flujo de salida para escribir en el archivo especificado.
     * 
     * @param nombre Nombre del archivo que se va a abrir.
     * @throws FileNotFoundException Si no se puede abrir el archivo.
     * @throws IOException Si la abertura del flujo falla.
     */
    public void abrir(String nombre) throws FileNotFoundException, IOException
    {
        flujo = new ObjectOutputStream(new FileOutputStream(nombre));
    }
    
    /*****************************************************/
    
    /**
     * @brief Escribe en el archivo binario previamente abierto las cadenas de caracteres indicadas.
     * 
     * @param contenido Caracteres que contendrá el archivo.
     * @throws IOException Si la operación de escritura falla.
     */
    public void escribir (String contenido) throws IOException
    {
        flujo.writeObject(contenido);
    }
    
    /*****************************************************/
    
    /**
     * @brief Cierra el flujo de salida actual si está abierto.
     * 
     * @throws IOException Si falla la operación de cierre del flujo.
     */
    public void cerrar () throws IOException
    {
        if (flujo != null)
            flujo.close();
    }
    
    /*****************************************************/
} // Fin de la clase EscritorArchivo.