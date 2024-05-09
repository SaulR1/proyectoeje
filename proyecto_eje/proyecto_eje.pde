import processing.sound.*;

PImage fondo1;
PImage fondo2;
PImage fondo3; // Nuevo fondo
PImage imagenCentro;
SoundFile sonidoFondo1;
SoundFile sonidoFondo2;
SoundFile sonidoFondo3; // Nuevo sonido
int fondoActual = 1;
int transicion = 0; // Variable para controlar la transición

void setup() {
  // Tamaño de la pantalla completa
  fullScreen();

  // Carga de imágenes
  fondo1 = loadImage("../assets/Imagenes/feria.jpeg");
  fondo2 = loadImage("../assets/Imagenes/XV años.jpeg");
  fondo3 = loadImage("../assets/Imagenes/microbus.jpg");
  imagenCentro = loadImage("../assets/Imagenes/pngtree-beautiful-virgin-de-guadalupe-png-image_9065820.png");
   // Carga de sonidos
  sonidoFondo1 = new SoundFile(this, "../assets/Sonidos/AUD-20240429-WA0014.mp3");
  sonidoFondo2 = new SoundFile(this, "../assets/sonidos/AUD-20240429-WA0017.mp3");
  sonidoFondo3 = new SoundFile(this, "C:/Users/saulc/OneDrive/Escritorio/proyecto_eje/assets/Sonidos/utomp3.com - Kamen Rider Wizard Water Style Henshin.mp3");
  // Reproducir sonido de fondo inicial
  sonidoFondo1.play();

}

void draw() {
  if (fondoActual == 1) {
    image(fondo1, 0, 0, width, height);
  } else if (fondoActual == 2) {
    image(fondo2, 0, 0, width, height);
  } else {
    image(fondo3, 0, 0, width, height); // Mostrar el nuevo fondo
  }

  float centroX = width / 2 - imagenCentro.width / 2;
  float centroY = height / 2 - imagenCentro.height / 2;
  image(imagenCentro, centroX, centroY);

  if (transicion > 0) {
    tint(255, transicion);
    transicion -= 30;
  }
}

void cambiarFondo() {
  if (fondoActual == 1) {
    sonidoFondo1.stop();
  } else if (fondoActual == 2) {
    sonidoFondo2.stop();
  } else {
    sonidoFondo3.stop(); // Detener el sonido actual si el fondo es el tercero
  }

  if (fondoActual == 1) {
    fondoActual = 2;
    sonidoFondo2.play();
  } else if (fondoActual == 2) {
    fondoActual = 3;
    sonidoFondo3.play(); // Reproducir el nuevo sonido si el fondo es el tercero
  } else {
    fondoActual = 1;
    sonidoFondo1.play();
  }

  transicion = 255;
}

void keyPressed() {
  if (key == 'q' || key == 'Q') {
    cambiarFondo();
  }
}
