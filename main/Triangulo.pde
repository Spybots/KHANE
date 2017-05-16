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
