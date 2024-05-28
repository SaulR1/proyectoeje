int buttonPin = 2; // Pin donde está conectado el botón
int buttonState; // Estado actual del botón
int lastButtonState = LOW; // Estado anterior del botón
unsigned long lastDebounceTime = 0; // Tiempo de última lectura estable
unsigned long debounceDelay = 50; // Tiempo de debounce

void setup() {
  pinMode(buttonPin, INPUT);
  Serial.begin(9600); // Iniciar la comunicación serial a 9600 bps
}

void loop() {
  int reading = digitalRead(buttonPin);

  // Comprueba si hay cambios en la lectura del botón
  if (reading != lastButtonState) {
    // Reinicia el temporizador de debounce
    lastDebounceTime = millis();
  }

  // Si el tiempo de debounce ha pasado
  if ((millis() - lastDebounceTime) > debounceDelay) {
    // Si el estado de la lectura ha cambiado
    if (reading != buttonState) {
      buttonState = reading;

      // Solo enviar el mensaje cuando el botón esté presionado
      if (buttonState == HIGH) {
        Serial.println("BUTTON_PRESSED");
      }
    }
  }

  // Guardar el estado de la lectura actual
  lastButtonState = reading;
}

