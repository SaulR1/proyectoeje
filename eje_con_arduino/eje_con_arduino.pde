import processing.sound.*;
import processing.serial.*;

PImage[] fondos = new PImage[5];
SoundFile[] sonidosFondo = new SoundFile[5];
int fondoActual = 0;
int transicion = 0;
Serial myPort; // Crear objeto serial para comunicarse con Arduino

void setup() {
  fullScreen();

  // Configurar la comunicación serial con Arduino
  String portName = Serial.list()[0]; // Asegúrate de seleccionar el puerto correcto
  myPort = new Serial(this, portName, 9600);

  // Cargar imágenes de fondo y sonidos de fondo
  for (int i = 0; i < 5; i++) {
    fondos[i] = loadImage("fondo" + (i + 1) + ".jpg");
    sonidosFondo[i] = new SoundFile(this, "sonido_fondo" + (i + 1) + ".mp3");
  }

  // Reproducir el primer sonido de fondo
  sonidosFondo[0].play();
}

void draw() {
  // Dibujar el fondo actual
  image(fondos[fondoActual], 0, 0, width, height);

  // Aplicar transición si hay una
  if (transicion > 0) {
    tint(255, transicion);
    rect(0, 0, width, height);
    transicion -= 5;
  }

  // Leer datos del puerto serial
  while (myPort.available() > 0) {
    String inString = myPort.readStringUntil('\n');
    if (inString != null) {
      inString = trim(inString);
      if (inString.equals("BUTTON_PRESSED")) {
        cambiarFondo();
      }
    }
  }
}

// Cambiar al siguiente fondo y detener el sonido actual
void cambiarFondo() {
  // Detener el sonido actual
  sonidosFondo[fondoActual].stop();

  // Cambiar al siguiente fondo
  fondoActual = (fondoActual + 1) % 5;

  // Reproducir el sonido correspondiente al nuevo fondo
  sonidosFondo[fondoActual].play();

  // Iniciar transición
  transicion = 255;
}
