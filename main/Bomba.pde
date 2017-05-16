boolean mostrarMicrojuego = false;
short microjuegoActual = 0;

void actualizarJuego()
{
    if (mostrarMicrojuego) {
        microjuegos.get(microjuegoActual).actualizar();
    } else {
        renderizarMaletinJuego();
    }
}

void renderizarMaletinJuego()
{
    translate(width/2, height/2, 0);
    //rotateY(PI/8);
    fill(255);
    box(width, height, 50);
    
    fill(0);
    translate(-width/2, -height/2, 0);
    line(width/2, 0, 100, width/2, height, 100);
    line(0, height/2, 100, width, height/2, 100);
}

void procesarClickBomba()
{
    if (mostrarMicrojuego) {
        microjuegos.get(microjuegoActual).procesarClick();
    } else {
        // Decidir sobre que cuadrante hizo click el usuario.
    }
}