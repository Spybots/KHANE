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
