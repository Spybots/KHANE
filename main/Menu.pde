PImage logo;
PGraphics botonIniciar, botonAjustes, botonPuntuaciones, botonSalir;
int anchoBoton, alturaBoton;

void crearBotones()
{
    botonIniciar = createGraphics(width, height, P2D);
    botonAjustes = createGraphics(width, height, P2D);
    botonPuntuaciones = createGraphics(width, height, P2D);
    botonSalir = createGraphics(width, height, P2D);
    //logo = loadImage("./img/sanic.png");
    
    anchoBoton = width/8;
    alturaBoton = height/8;
}

void desplegarMenu()
{
    textAlign(CENTER);

    text("Keep Hacking and Nobody Explodes", width/2, height/4);
    imageMode(CENTER);
    //image(logo, width/2, height/4 + 120, 200, 200);
    
    rect(width/2 - 100, height/2 + 100, 200, 50);
    //text("Iniciar", width/2, height/2 + 100);
    //text("Ajustes", width/2, height/2 + 150);
    //text("Puntuaciones", width/2, height/2 + 200);
    //text("Salir", width/2, height/2 + 250);
    
    //image(botonIniciar, 0, 0);
}

void procesarClickMenu()
{
    if (mouseX >= width/2 - 100 &&
        mouseX <= width/2 + 100 &&
        mouseY >= height/2 + 100 &&
        mouseY <= height/2 + 150) {
        println("Vamos a jugar.");
    }
}