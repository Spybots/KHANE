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
