import java.lang.StringBuilder;

//MetodosConteo conteoJuego = new MetodosConteo();

/*void setup(){
  size(1000,1000);
}

void draw(){
     conteoJuego.dibujarMetodoConteo();
}*/

/*
class MetodosConteo extends Microjuego{
     Figura figura[][];
     float tamRadio;
     String valorIngresado;

     MetodosConteo(){
          tamRadio = 50;
          figura = new Figura[2][];
          establecerGruposFiguras();
     }

     void dibujarMetodoConteo(){
          background(102);
          dibujarGrupoFiguras(0, 50);   //Mandamos el indice del prmer grupo y la posicion del eje y en el que se dibujaran.
          dibujarGrupoFiguras(1, 200);  //Mandamos el indice del prmer grupo y la posicion del eje y en el que se dibujaran.
     }

     void establecerGruposFiguras(){
          boolean seguirBuscandoRandom = true;
          int numerosYaEscogidos[] = new int[4];
          int tamGrupo = 1, tamGrupoAnterior = 0, r = 1;

          for(int i = 0; i < 2; i++){
               while(seguirBuscandoRandom){
                    if(i == 0){
                         r = (int)(random(1, 5)); //Es para escoger una figura;
                         tamGrupo = (int)(random(1, 6)); //Para escoger el tamaño del grupo.
                         seguirBuscandoRandom = false;
                         tamGrupoAnterior = tamGrupo;
                         numerosYaEscogidos[0] = r;
                    }else{    //Si entro a aqui eso quiere decir que esta seleccionando el grupo de figuras no. 2
                         r = (int)(random(1, 5)); //Es para escoger una figura;
                         tamGrupo = (int)(random(1, tamGrupoAnterior)); //Para escoger el tamaño del grupo.
                         if(tamGrupo > tamGrupoAnterior){
                              seguirBuscandoRandom = true;
                         }else{
                              for(int j = 0; j < i; j++){
                                   if(numerosYaEscogidos[j] == r){
                                        seguirBuscandoRandom = true;
                                        break;
                                   }else{
                                        seguirBuscandoRandom = false;
                                        numerosYaEscogidos[j] = r;
                                        break;
                                   }
                              }
                         }
                    }
               }
               seguirBuscandoRandom = true;
               int colorRandom = (int)(random(4));
               Color colorEscogido;
               switch(colorRandom){
                    case 0:   colorEscogido = Color.BLUE;
                              break;
                    case 1:   colorEscogido = Color.GREEN;
                              break;
                    case 2:   colorEscogido = Color.ORANGE;
                              break;
                    default:   colorEscogido = Color.PINK;
                              break;
               }

               figura[i] = new Figura[tamGrupo];

               for(int j = 0; j < tamGrupo; j++){
                    switch(r){
                         case 1:   figura[i][j] = new Rectangulo(tamRadio, colorEscogido, tamGrupo);     //Rectangulo
                                   break;
                         case 2:   figura[i][j] = new Triangulo(tamRadio, colorEscogido, tamGrupo);     //Triangulo
                                   break;
                         case 3:   figura[i][j] = new Circulo(tamRadio, colorEscogido, tamGrupo);   //Circulo
                                   break;
                         default:  figura[i][j] = new Pentagono(tamRadio, colorEscogido, tamGrupo);     //Pentagono
                                   break;
                    }
               }
          }
          println(figura[0][0].obtenerNombreFigura());
          println(figura[0][0].obtenerCadenaColor());
          println("Lo hicimos!!!");
     }

     void dibujarGrupoFiguras(int indiceFig, int posY){
          int posX = 100;

          for(int i = 0; i < figura[indiceFig][0].obtenerTamGrupo(); i++){
               figura[indiceFig][i].dibujar(posX, posY);
               posX+=100;
          }
     }

     void keyPressed(){
          switch(key){
               case '0': println("key:" + "0");
                         sumarValorIngresado("0");
                         break;
               case '1': println("key:" + "1");
                         sumarValorIngresado("1");
                         break;
               case '2': println("key:" + "2");
                         sumarValorIngresado("2");
                         break;
               case '3': println("key:" + "3");
                         sumarValorIngresado("3");
                         break;
               case '4': println("key:" + "4");
                         sumarValorIngresado("4");
                         break;
               case '5': println("key:" + "5");
                         sumarValorIngresado("5");
                         break;
               case '6': println("key:" + "6");
                         sumarValorIngresado("6");
                         break;
               case '7': println("key:" + "7");
                         sumarValorIngresado("7");
                         break;
               case '8': println("key:" + "8");
                         sumarValorIngresado("8");
                         break;
               case '9': println("key:" + "9");
                         sumarValorIngresado("9");
                         break;
               case BACKSPACE:     println("key:" + "BACKSPACE");
                                   restarValor();
                                   break;
               case ENTER:
                              break;
               default:  break;
         }
     }

     void sumarValorIngresado(String numAgregar){
          if(valorIngresado == ""){
               valorIngresado = numAgregar;
          }else{
               valorIngresado += numAgregar;
          }
     }

     void restarValor(){
          if(valorIngresado.length() > 0){
               StringBuilder sb = new StringBuilder(valorIngresado);
               sb.deleteCharAt(valorIngresado.length() - 1);
               valorIngresado = sb.toString();
          }
     }

     //Azul arriba y verde abajo = permutaciones de azul en verda;
	//Azul arriba y naranja abajo = combinaciones de azul en naranja;
	//Azul arriba y rosa abajo = permutaciones de azul en rosa;
	//Verde arriba y azul abajo = combinaciones de verde en azul;
	//Verde arriba y naranja abajo = permutaciones de verde en azul;
	//Verde arriba y rosa abajo = combinaciones de verde en azul;
	//Naranja arriba y azul abajo = permutaciones de naranja en azul;
	//Naranja arriba y verde abajo = combinaciones de naranja en verde;
	//Naranja arriba y Rosa abajo = permutaciones de naranja en rosa;
	//Rosa arriba y azul abajo = combinaciones de rosa en azul;
	//Rosa arriba y verde abajo = combinaciones de rosa en verde;
	//Rosa arriba y naranja abajo = combinaciones de rosa en naranja;
     void verificarRespuesta(){
          if(figua[0][0].obtenerColor() == Color.BLUE){     //Si es azul el gurpo de arriba
               if(figua[1][0].obtenerColor() == Color.GREEN || figua[1][0].obtenerColor() == Color.PINK){     //Permutaciones

               }else{    //combinaciones

               }

          }else{
               if(figua[0][0].obtenerColor() == Color.GREEN){    //Si es verde el grupo de arriba
                    if(figua[1][0].obtenerColor() == Color.ORANGE){   //permutaciones

                    }else{    //combinaciones

                    }
               }else{
                    if(figua[0][0].obtenerColor() == Color.ORANGE){   //Si es naranja el grupo de arriba
                         if(figua[1][0].obtenerColor() == Color.BLUE || figua[1][0].obtenerColor() == Color.PINK){   //permutaciones

                         }else{    //combinaciones

                         }
                    }else{
                         if(figua[0][0].obtenerColor() == Color.ORANGE){   //Si es Rosa el grupo de arriba
                              if(figua[1][0].obtenerColor() == Color.GREEN){   //permutaciones

                              }else{    //combinaciones

                              }
                         }
                    }
               }
          }
     }

}
*/