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

     Color obtenerColor(){
          return this.colorFig;
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

//**************Clase Rectangulo******************************
class Rectangulo extends Figura{
     Rectangulo(float tamRadio, Color colorFig, int tamGrupo){
          this.tamRadio = tamRadio;
          this.colorFig = colorFig;
          this.tamGrupo = tamGrupo;
          this.cadenaFigura = "Rectangulo";
          this.tipoFigura = 1;     //1 significa que es un Rectangulo
     }

     void dibujar(int posX, int posY){
          fill(this.colorFig.getRed(), this.colorFig.getGreen(), this.colorFig.getBlue());
          float angulo = TWO_PI / 4;
          beginShape();
          for (float a = 0; a < TWO_PI; a += angulo) {
               float sx = posX + cos(a) * this.tamRadio;
               float sy = posY + sin(a) * this.tamRadio;
            vertex(sx, sy);
          }
          endShape(CLOSE);
          noFill();
     }
}

//******************Clase Triangulo*************************
class Triangulo extends Figura{
     Triangulo(float tamRadio, Color colorFig, int tamGrupo){
          this.tamRadio = tamRadio;   //En el caso del Triangulo tamLado es el tamaño del diametro
          this.colorFig = colorFig;
          this.tamGrupo = tamGrupo;
          this.cadenaFigura = "Triangulo";
          this.tipoFigura = 2;     //4 significa que es un Triangulo
     }

     void dibujar(int posX, int posY){
          fill(this.colorFig.getRed(), this.colorFig.getGreen(), this.colorFig.getBlue());
          float angulo = TWO_PI / 5;     //5 porque es un pentagono
          beginShape();
          for (float a = 0; a < TWO_PI; a += angulo) {
               float sx = posX + cos(a) * this.tamRadio;
               float sy = posY + sin(a) * this.tamRadio;
            vertex(sx, sy);
          }
          endShape(CLOSE);
          noFill();
     }
}

//****************Clase Circulo******************************
class Circulo extends Figura{
     Circulo(float tamRadio, Color colorFig, int tamGrupo){
          this.tamRadio = tamRadio;   //En el caso del circulo tamLado es el tamaño del diametro
          this.colorFig = colorFig;
          this.tamGrupo = tamGrupo;
          this.cadenaFigura = "Circulo";
          this.tipoFigura = 3;     //3 significa que es un Circulo
     }

     void dibujar(int posX, int posY){
          fill(this.colorFig.getRed(), this.colorFig.getGreen(), this.colorFig.getBlue());

          ellipse(posX, posY, this.tamRadio*2, this.tamRadio*2);
          noFill();
     }
}

//*******************Clase Pentagono***************************
class Pentagono extends Figura{
     Pentagono(float tamRadio, Color colorFig, int tamGrupo){
          this.tamRadio = tamRadio;   //En el caso del Pentagono tamRadio es el tamaño del diametro
          this.cadenaFigura = "Pentagono";
          this.colorFig = colorFig;
          this.tamGrupo = tamGrupo;
          this.tipoFigura = 4;     //4 significa que es un Pentagono
     }

     void dibujar(int posX, int posY){
          fill(this.colorFig.getRed(), this.colorFig.getGreen(), this.colorFig.getBlue());
          float angulo = TWO_PI / 5;     //5 porque es un pentagono
          beginShape();
          for (float a = 0; a < TWO_PI; a += angulo) {
               float sx = posX + cos(a) * this.tamRadio;
               float sy = posY + sin(a) * this.tamRadio;
            vertex(sx, sy);
          }
          endShape(CLOSE);
          noFill();
     }
}
