class Reloj{
     int cx, cy;
     float secondsRadius;
     float minutesRadius;
     float hoursRadius;
     float clockDiameter;
     int sec, min, start, timer;

     /**
     *@brief Constructor de la clase. Inicializa las variables de la clase.
     */
     Reloj()
     {
          int radius = min(width, height) / 4;
          secondsRadius = radius * 0.72;
          minutesRadius = radius * 0.60;
          clockDiameter = radius * 1.8;

          cx = width / 2;
          cy = height / 2;

          sec = 0;
          min = 0;
          start = millis();
          timer = 0;
     }

     /**
     *@brief Calcula el tiempo transucurrido desde que inicio el juego
     */
     void calcularTiempo(){
          timer += millis() - start;

          if(timer > 999){
               sec++;
               timer-=1000;
               if(sec > 59){
                    min++;
                    sec = 0;
                    if(min > 59){
                         min = 0;
                    }
               }
          }

          start=millis();
     }

     /**
     *@brief Dibuja en el medio de la pantalla un reloj analogico.
     */
     void dibujarRelojAnalogico()
     {

          // Draw the clock background
          fill(80);
          noStroke();
          ellipse(cx, cy, clockDiameter, clockDiameter);

          float s = map(sec , 0, 60, 0, TWO_PI) - HALF_PI;
          float m = map(min + norm(sec, 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;

          // Draw the hands of the clock
          stroke(255);
          strokeWeight(1);
          line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
          strokeWeight(2);
          line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
          //strokeWeight(4);
          //line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);

          // Draw the minute ticks
          strokeWeight(2);
          beginShape(POINTS);
          for (int a = 0; a < 360; a+=6) {
            float angle = radians(a);
            float x = cx + cos(angle) * secondsRadius;
            float y = cy + sin(angle) * secondsRadius;
            vertex(x, y);
          }
          endShape();
     }

     /**
     *@brief Regresa el tiempo que ha transcurrido desde que una parida inicio en milisegundos.
     *@return El tiempo que ha transcurrido desde que una partida inicio en milisegundos.
     */
     int obtenerTiempoMilis(){
          return this.timer + this.sec*1000 + this.min*60*1000;
     }

     String obtenerMinCadena(){
          String minutos;
          if(this.min < 10){
               minutos = "0" + String.valueOf(this.min);
          }else{
               minutos = String.valueOf(this.min);
          }

          return minutos;
     }

     String obtenerSegCadena(){
          String segundos;
          if(this.sec < 10){
               segundos = "0" + String.valueOf(this.sec);
          }else{
               segundos = String.valueOf(this.sec);
          }

          return segundos;
     }

     /**
     *@brief Dibuja un reloj digital en la pantalla.
     */
     void dibujarRelojDigital(){
          println(obtenerMinCadena() + ":" + obtenerSegCadena());
          textSize(25);
          fill(255);
          switch(microjuegos.get(microjuegoActual).obtenerID()){
               case 1:   text(obtenerMinCadena() + ":" + obtenerSegCadena(), width - 40, height - 25); //Dibuja el texto que se lleva ingresado
                         break;
               case 2:   text(obtenerMinCadena() + ":" + obtenerSegCadena(), 40, height - 25); //Dibuja el texto que se lleva ingresado
                         break;
               case 3:   text(obtenerMinCadena() + ":" + obtenerSegCadena(), width - 40, 25); //Dibuja el texto que se lleva ingresado
                         break;
               case 4:   text(obtenerMinCadena() + ":" + obtenerSegCadena(), 40, 60); //Dibuja el texto que se lleva ingresado
                         break;
               default:  println("no entro a ninguno");
                         break;
          }
     }
}
