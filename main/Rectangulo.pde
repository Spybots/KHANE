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
