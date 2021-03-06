import java.lang.StringBuilder;

/**
* @brief clase para el minijuego de metodos de conteo.
*/
class MetodosConteo extends Microjuego{
     Figura figura[][];
     float tamRadio;
     String valorIngresado;
     int noAciertos;
     boolean haGanado;

     /**
     * @brief constructuro de la clase MetodosConteo que inicializa las variables de la clase.
     */
     MetodosConteo(){
          this.tamRadio = 50;
          this.figura = new Figura[2][];
          this.termino = false;
          this.fallo = false;
          this.puntaje = 0;
          this.fallos = 0;
          this.nombre = "Metodos de conteo";
          this.valorIngresado = "";
          this.noAciertos = 0;
	  this.ID = 2;
	  this.haGanado = false;
          establecerGruposFiguras();
     }

     /**
     * @brief Inicializa los conjuntos para los metodos de conteo
     */
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
               Color colorEscogido;
               if( i == 0){
                    seguirBuscandoRandom = true;
                    int colorRandom = (int)(random(4));
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
               }else{
                    do{
                         seguirBuscandoRandom = true;
                         int colorRandom = (int)(random(4));
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

                    }while(colorEscogido == figura[0][0].obtenerColor());
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
     }

     /**
     * @brief Dibuja en la pantalla los conjuntos,
     */
     void dibujarGrupoFiguras(int indiceFig, int posY){
          int posX = 150;

          for(int i = 0; i < figura[indiceFig][0].obtenerTamGrupo(); i++){
               figura[indiceFig][i].dibujar(posX, posY);
               posX+=150;
          }
     }

     /**
     * @brief procesa las teclas ingresadas para poder usar el minijuego
     */
     void procesarTeclas(){
          if(this.haGanado == false){
               switch(key){
                    case '0': sumarValorIngresado("0");
                              break;
                    case '1': sumarValorIngresado("1");
                              break;
                    case '2': sumarValorIngresado("2");
                              break;
                    case '3': sumarValorIngresado("3");
                              break;
                    case '4': sumarValorIngresado("4");
                              break;
                    case '5': sumarValorIngresado("5");
                              break;
                    case '6': sumarValorIngresado("6");
                              break;
                    case '7': sumarValorIngresado("7");
                              break;
                    case '8': sumarValorIngresado("8");
                              break;
                    case '9': sumarValorIngresado("9");
                              break;
                    case BACKSPACE:     restarValor();
                                        break;
                    case ENTER:    verificarRespuesta();
                                   break;
                    default:  println("entrada no valida");
                              break;
              }
          }
     }

     /**
     * @brief suma la tecla presionada al valor que el usuario lleva acumulado presionando teclas.
     */
     void sumarValorIngresado(String numAgregar){
          if(this.valorIngresado.length() < 5){
               if(this.valorIngresado == ""){
                    this.valorIngresado = numAgregar;
               }else{
                    this.valorIngresado += numAgregar;
               }
          }
     }

     /**
     * @brief resta el ultimo digito del valor que el usuario lleva acumulado presionando teclas. i.e. 123456 -> 12345
     */
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

     /**
     * @brief Procesa la respuesta del usuario para verificar si es correcta o no
     */
     void verificarRespuesta(){
          if(figura[0][0].obtenerColor() == Color.BLUE){     //Si es azul el gurpo de arriba
               if(figura[1][0].obtenerColor() == Color.GREEN || figura[1][0].obtenerColor() == Color.PINK){     //Permutaciones
                    int n = figura[0][0].obtenerTamGrupo();
                    int r = figura[1][0].obtenerTamGrupo();
                    int respCorrecta = calcularFactorial(n)/(calcularFactorial(n-r));

                    if( Integer.parseInt(valorIngresado) == respCorrecta){
                         //Procesar respuesta correcta
			 this.noAciertos++;
                         if(this.noAciertos > 2){
                              this.fallo = false;
                              this.termino = true;
                              this.haGanado = true;
                              calcularPuntaje();
                         }else{
                              establecerGruposFiguras();
                         }
                         valorIngresado = "";

                    }else{
                         //Processar respuesta incorrecta
                         this.fallos++;
			 if ( this.fallos > 2) {
			     this.fallo = true;
			     this.termino = false;
			     calcularPuntaje();
			 }
			 valorIngresado = "";
                    }
               }else{    //combinaciones
                    int n = figura[0][0].obtenerTamGrupo();
                    int r = figura[1][0].obtenerTamGrupo();
                    int respCorrecta = calcularFactorial(n)/((calcularFactorial(r))*(calcularFactorial(n-r)));

                    if( Integer.parseInt(valorIngresado) == respCorrecta){
                         //Procesar respuesta correcta
                         this.noAciertos++;
                         if(this.noAciertos > 2){
                              this.fallo = false;
                              this.termino = true;
                              this.haGanado = true;
                              calcularPuntaje();
                         }else{
                              establecerGruposFiguras();
                         }
                         valorIngresado = "";
                    }else{
                         //Processar respuesta incorrecta
                         this.fallos++;
			 if ( this.fallos > 2) {
			     this.fallo = true;
			     this.termino = false;
			     calcularPuntaje();
			 }
			 valorIngresado = "";
                    }
               }

          }else{
               if(figura[0][0].obtenerColor() == Color.GREEN){    //Si es verde el grupo de arriba
                    if(figura[1][0].obtenerColor() == Color.ORANGE){   //permutaciones
                         int n = figura[0][0].obtenerTamGrupo();
                         int r = figura[1][0].obtenerTamGrupo();
                         int respCorrecta = calcularFactorial(n)/(calcularFactorial(n-r));

                         if( Integer.parseInt(valorIngresado) == respCorrecta){
                              //Procesar respuesta correcta
                              this.noAciertos++;
                              if(this.noAciertos > 2){
                                   this.fallo = false;
                                   this.termino = true;
                                   this.haGanado = true;
                                   calcularPuntaje();
                              }else{
                                   establecerGruposFiguras();
                              }
                              valorIngresado = "";
                         }else{
                              //Processar respuesta incorrecta
                              this.fallos++;
			      if ( this.fallos > 2) {
				      this.fallo = true;
				      this.termino = false;
				      calcularPuntaje();
			      }
			      valorIngresado = "";
                         }
                    }else{    //combinaciones
                         int n = figura[0][0].obtenerTamGrupo();
                         int r = figura[1][0].obtenerTamGrupo();
                         int respCorrecta = calcularFactorial(n)/((calcularFactorial(r))*(calcularFactorial(n-r)));

                         if( Integer.parseInt(valorIngresado) == respCorrecta){
                              //Procesar respuesta correcta
                              this.noAciertos++;
                              if(this.noAciertos > 2){
                                   this.fallo = false;
                                   this.termino = true;
                                   this.haGanado = true;
                                   calcularPuntaje();
                              }else{
                                   establecerGruposFiguras();
                              }
                              valorIngresado = "";
                         }else{
                              //Processar respuesta incorrecta
                              this.fallos++;
			      if ( this.fallos > 2) {
				     this.fallo = true;
				     this.termino = false;
				     calcularPuntaje();
			      }
			      valorIngresado = "";
                         }
                    }
               }else{
                    if(figura[0][0].obtenerColor() == Color.ORANGE){   //Si es naranja el grupo de arriba
                         if(figura[1][0].obtenerColor() == Color.BLUE || figura[1][0].obtenerColor() == Color.PINK){   //permutaciones
                              int n = figura[0][0].obtenerTamGrupo();
                              int r = figura[1][0].obtenerTamGrupo();
                              int respCorrecta = calcularFactorial(n)/(calcularFactorial(n-r));

                              if( Integer.parseInt(valorIngresado) == respCorrecta){
                                   //Procesar respuesta correcta
                                   this.noAciertos++;
                                   if(this.noAciertos > 2){
                                        this.fallo = false;
                                        this.termino = true;
                                        this.haGanado = true;
                                        calcularPuntaje();
                                   }else{
                                        establecerGruposFiguras();
                                   }
                                   valorIngresado = "";
                              }else{
                                   //Processar respuesta incorrecta
                                   if ( this.fallos > 2) {
				     this.fallo = true;
				     this.termino = false;
				     calcularPuntaje();
			           }
			           valorIngresado = "";
                              }
                         }else{    //combinaciones
                              int n = figura[0][0].obtenerTamGrupo();
                              int r = figura[1][0].obtenerTamGrupo();
                              int respCorrecta = calcularFactorial(n)/((calcularFactorial(r))*(calcularFactorial(n-r)));

                              if( Integer.parseInt(valorIngresado) == respCorrecta){
                                   //Procesar respuesta correcta
                                   this.noAciertos++;
                                   if(this.noAciertos > 2){
                                        this.fallo = false;
                                        this.termino = true;
                                        this.haGanado = true;
                                        calcularPuntaje();
                                   }else{
                                        establecerGruposFiguras();
                                   }
                                   valorIngresado = "";
                              }else{
                                   //Processar respuesta incorrecta
                                   if ( this.fallos > 2) {
				     this.fallo = true;
				     this.termino = false;
				     calcularPuntaje();
			           }
			           valorIngresado = "";
                              }
                         }
                    }else{
                         if(figura[0][0].obtenerColor() == Color.PINK){   //Si es Rosa el grupo de arriba
                              if(figura[1][0].obtenerColor() == Color.GREEN){   //permutaciones
                                   int n = figura[0][0].obtenerTamGrupo();
                                   int r = figura[1][0].obtenerTamGrupo();
                                   int respCorrecta = calcularFactorial(n)/(calcularFactorial(n-r));

                                   if( Integer.parseInt(valorIngresado) == respCorrecta){
                                        //Procesar respuesta correcta
                                        this.noAciertos++;
                                        if(this.noAciertos > 2){
                                             this.fallo = false;
                                             this.termino = true;
                                             this.haGanado = true;
                                             calcularPuntaje();
                                        }else{
                                             establecerGruposFiguras();
                                        }
                                        valorIngresado = "";
                                   }else{
                                        //Processar respuesta incorrecta
                                        this.fallos++;
                                        if ( this.fallos > 2) {
                                            this.fallo = true;
                                            this.termino = false;
					    calcularPuntaje();
                                        }
                                        valorIngresado = "";
                                   }
                              }else{    //combinaciones
                                   int n = figura[0][0].obtenerTamGrupo();
                                   int r = figura[1][0].obtenerTamGrupo();
                                   int respCorrecta = calcularFactorial(n)/((calcularFactorial(r))*(calcularFactorial(n-r)));

                                   if( Integer.parseInt(valorIngresado) == respCorrecta){
                                        //Procesar respuesta correcta
                                        this.noAciertos++;
                                        if(this.noAciertos > 2){
                                             this.fallo = false;
                                             this.termino = true;
                                             this.haGanado = true;
                                             calcularPuntaje();
                                        }else{
                                             establecerGruposFiguras();
                                        }
                                        valorIngresado = "";
                                   }else{
                                        //Processar respuesta incorrecta
                                        this.fallos++;
                                        if ( this.fallos > 2) {
                                            this.fallo = true;
                                            this.termino = false;
					    calcularPuntaje();
                                        }
                                        valorIngresado = "";
                                   }
                              }
                         }
                    }
               }
          }
     }

     /**
     * @brief Funcion basica para procesar el factorial de un numero.
     * @return El factorial de del argumento n.
     */
     int calcularFactorial(int n){
          if (n==0)
            return 1;
          else
            return n * calcularFactorial(n-1);
     }

     /**
     * @brief Devuelve si el usuario ha fallado en el microjuego desde la última vez que se
     * mandó a llamar esta función.
     * @return Verdadero si hay un fallo, falso de otro modo.
     */
     boolean obtenerFallo(){
          return this.fallo;
     }

     /**
      * @brief Devuelve si el microjuego ha terminado.
      * @return Verdadero si el microjuego terminó, falso de otro modo.
      */
     boolean obtenerTermino(){
          return this.termino;
     }

     /**
      * @brief Calcula el puntaje actual del microjuego.
      */
     void calcularPuntaje(){
          puntaje = noAciertos*1000 + (int)((180000 - relojPrincipal.obtenerTiempoMilis())*0.2); //Ver como exactamente se calcularan el puntaje.
     }

     /**
      * @brief Actualiza el estado visual actual del microjuego que está jugando el usuario o del
      * maletín para seleccionar el nivel.
      */
     void actualizar(){
          if(this.haGanado == false){
               background(102);
               dibujarGrupoFiguras(0, 50);   //Mandamos el indice del prmer grupo y la posicion del eje y en el que se dibujaran.
               dibujarGrupoFiguras(1, 200);  //Mandamos el indice del prmer grupo y la posicion del eje y en el que se dibujaran.
               textSize(32);
               fill(255);
               text(valorIngresado, 200, 500); //Dibuja el texto que se lleva ingresado
          }else{

               background(102);
               textSize(68);
               fill(255);
               text("Has terminado este modulo\n\nTu puntaje es: " + this.puntaje, width/2, height/2); //Dibuja el texto que se lleva ingresado
               textSize(20);
               fill(255);
               text("\n\n\n\nPresione Tab para regresar a la seleccion de los otros modulos",  width/2, height/2 + 200);
          }
     }

     /**
     * @brief Modifica el estado actual del microjuego cuando el usuario hace click en pantalla.
     */
     void procesarClick(){
     }
}//***********Fin de la clase MetodosDeConteo
