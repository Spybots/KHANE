PImage botonIniciar, botonAjustes, botonPuntuaciones, botonSalir;
int anchoBoton, alturaBoton, padding;

void crearBotones()
{
    botonAjustes = loadImage("./img/ajustes.png");
    botonPuntuaciones = loadImage("./img/puntuaciones.png");
    botonSalir = loadImage("./img/salir.png");
    botonIniciar = loadImage("./img/iniciar.png");

    anchoBoton = width/4;
    alturaBoton = height/8;
    padding = alturaBoton/10;
}

void desplegarMenu()
{
    textAlign(CENTER);
    textSize(MAGNITUD_TEXTO);
    text("Keep Hacking and Nobody Explodes", width/2, height/4);

    image(botonIniciar, width/2 - anchoBoton/2, height/2 - alturaBoton/2, anchoBoton, alturaBoton);
    image(botonAjustes, width/2 - anchoBoton/2, height/2 + alturaBoton/2 + padding, anchoBoton, alturaBoton);
    image(botonPuntuaciones, width/2 - anchoBoton/2, height/2 + 3*alturaBoton/2 + padding, anchoBoton, alturaBoton);
    image(botonSalir, width/2 - anchoBoton/2, height/2 + 5*alturaBoton/2 + padding, anchoBoton, alturaBoton);
}

void procesarClickMenu()
{
    if (mouseX >= width/2 - anchoBoton/2 && mouseX <= width/2 + anchoBoton/2) {
        if (mouseY >= height/2 - alturaBoton/2 && mouseY <= height/2 + alturaBoton/2) {
            muestraMenu = false;
            muestraJuego = true;
            
            microjuegos = new ArrayList<Microjuego>();
            microjuegos.add(new Cipher());
            microjuegos.add(new PaseoEuler());
            //microjuegos.add(new MetodosConteo());
            microjuegos.add(new Discos());
        } else if (mouseY >= height/2 + alturaBoton/2 + padding && 
                   mouseY < height/2 + 3*alturaBoton/2 + padding) {
            background(0, 200, 200);
        } else if (mouseY >= height/2 + 3*alturaBoton/2 + padding && 
                   mouseY < height/2 + 5*alturaBoton/2 + padding) {
            background(200, 200, 200);
        } else if (mouseY >= height/2 + 5*alturaBoton/2 + padding && 
                   mouseY < height/2 + 7*alturaBoton/2 + padding) {
            background(50, 225, 100);
        }
    }
}