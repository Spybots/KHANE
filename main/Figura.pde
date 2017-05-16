import java.awt.Color;

abstract class Figura{
     String cadenaFigura;
     int tipoFigura;     //1-Cuadrado, 2-Triangulo, 3-Circulo, 4-Pentagono.
     float tamRadio; //En el caso del circulo sera el diametro
     Color colorFig;
     int tamGrupo;

     //Método para obtener el nombre de la figura
     String obtenerNombreFigura(){
          return this.cadenaFigura;
     }

     String obtenerCadenaColor(){
          return this.colorFig.toString();
     }

     //Metodo para obtener el tamaño de sus lados (todos sus lados son iguales y en el caso del circulo sera su diametro)
     float obtenertamRadio(){
          return this.tamRadio;
     }

     //Metodo para obtener el tipo de figura que es.
     int obtenerTipoFigura(){
          return this.tipoFigura;
     }

     int obtenerTamGrupo(){
          return this.tamGrupo;
     }

     abstract void dibujar(int posX, int posY);
}
