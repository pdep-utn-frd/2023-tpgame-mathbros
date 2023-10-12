from PIL import Image, ImageDraw, ImageFont
import textwrap
#from narrativa import lista
lista = [
  ['Estabas tratando de interpretar la primer ecuacion diferencial cuando sientes un estruendo en tu oreja izquierda. No te asustes. Alguien esta tocando la puerta. \nNo esperabas visitas. Incluso tienes el presentimiento de que no debes abrirle la puerta a nadie, el barrio esta peligroso y no podrias hacer nada ante la presencia de un malhechor.',
    'Abrir', 'No abrir', 'puerta-cerrada.jpeg'],
    ['Te autoconvences que eres un chad y decides ir a abrir la puerta sin que te tiemble la mano. Cuando sientes el frio del picaporte un gran sentimiento de terror aborda tu cuerpo, \naun asi, recuerdas que pasaste por momentos mas dificiles, como el examen final de Algebra y Geometria Analitica. Abres la puerta...',
    '...', '...', 'picaporte.jpeg'],
    ['La realidad misma se desdibuja al contemplar la presencia inusual del profesor de Paradigmas de Programación en el sancta sanctorum de tu hogar. Súbitamente, te asaltan sospechas sobre la autenticidad del mundo que conoces. ¿Será esta vida, en verdad, una intrincada simulación? Y, aún más desconcertante, ¿qué razón lo ha traído hasta tu umbral?\nEl profesor parece más inquieto de lo habitual, al punto de rayar en la ansiedad. Vuestras miradas se entrecruzan en un incómodo compás, llenando el aire con una tensión palpable, mientras el silencio se hace eco de interrogantes.\nFinalmente, el profesor rompe el muro de incertidumbre y, con voz tambaleante, plantea una cuestión enigmática: "¿Qué representa, en su esencia, la herencia en la programación orientada a objetos?"',
    'No lo recuerdo', 'Permite que se puedan definir nuevas clases basadas de unas ya existentes a fin de reutilizar el código', 'profesor.jpeg'],
    ['Una extraña sonrisa se dibuja en el rostro del profesor. Sus ojos se ensanchan y, con una voz ronca, pronuncia: "Bien".\nUnos eternos segundos transcurren antes de que otra palabra salga de sus labios: "Pero no es suficiente".\nSientes que estás perdiendo el control de tus extremidades, hasta que finalmente te desplomas, desmayado, en tu propia casa.',
     '...', '...', 'sonrisa-profesor.jpeg'],
    ['Ah, lamento comunicarte que has tomado un sendero poco afortunado. Tal vez no cabía la posibilidad de que lo supieras, pero aquí estamos. ¿Qué ocurrió? No lo sé. Yo, apenas un narrador, carezco de esa perspicacia. Lo único que puedo recordar es que cuando respondiste con un simple "No lo sé", Wollok se tambaleó y la ejecución de tu relato llegó a su abrupto final. ¿Desgarrador, verdad? Pero en última instancia, ¿qué somos sino una serie de algoritmos ejecutando un diálogo preconcebido por la mano invisible de guionistas? Aunque quizás, en mi ingenuidad, me atrevería a creer que somos conscientes de nuestra propia existencia, lamentablemente, esa noción se escapa de nuestro alcance. Espero tener el placer de encontrarte de nuevo en algún rincón de este vasto mundo, querido amigo.',
     '...', '...', 'muerte-filosofica.jpeg'],
     ['¡Despierta! Sí, abre los ojos. Te encuentras en este instante en un banco de la facultad. A simple vista, parece ser una de las típicas aulas de la UTN donde se imparten clases sobre Paradigmas. Sin embargo, tus sentidos captan una anomalía sutil: la escasez de estudiantes en la estancia.\nTras contar meticulosamente, llegas a cinco. Mientras el profesor se empeña en reforzar el concepto de herencia en el pizarrón, tus ojos, sin embargo, no pueden evitar desviarse hacia las expresiones de tus compañeros. No reflejan estar allí por elección propia, sino más bien por un enigma que los envuelve.', 
      'Decides salir corriendo', 'Te quedas a prestar atencion', 'aula.jpeg'],
      ['Como si se tratara de una competición olímpica, una súbita urgencia impulsa tus piernas a emprender un sprint desesperado hacia la puerta del aula. ¡Has recuperado tu libertad!\nO sea, digamos, si lo ponemos en estos terminos, puedes hacer de tu vida lo que quieras a partir de ahora.',
       'Recorrer los pasillos de la facu', 'Regresar a casa', 'sprint-aula.jpeg'],
       ['Qué buena explicación. Tu mente se siente reconfortada al entender finalmente qué es la herencia en el paradigma orientado a objetos. La clase ha terminado.\nHa sido extraño ser raptado de esta manera, pero, valió la pena el conocimiento adquirido ¿no?\nEres libre de la clase ¿ahora qué?',
        'Recorrer los pasillos de la facu', 'Regresar a casa', 'cerebro.jpeg'],
        ['Luego de una ardua clase, no hay nada mejor que caminar un poco. Oh, observas un vaso de carton en el suelo.', 
         'Agarrarlo para desecharlo', 'Ignorarlo, no te importa nada', 'vaso-descartable.jpeg'],
         ['Has optado por pasar por alto ese desecho en el suelo. No has contribuido a hacer del mundo un lugar mejor. Mis expectativas eran escasas, y, a pesar de ello, logras decepcionarme. Llegamos al final de nuestro camino juntos. No deseo seguir siendo el narrador de tu historia. Adiós.', '...', '...', 'black.jpg'],
         ['Te felicito, demuestras un deseo genuino de contribuir a la creación de un mundo mejor. Te encaminas hacia la esquina donde se encuentran los contenedores de reciclaje.\nAllí, ante ti, se despliegan tres opciones:\n1. Papel y cartón.\n2. Vidrio y plásticos.\n3. Orgánicos.\n No obstante, tu decisión se complica al notar que el vaso de cartón aún alberga residuos de yerba usada. La elección se torna repentinamente en una decisión crucial, como si tu destino dependiera de ello.\n¿Dónde decides desechar el vaso?',
          'Papel y carton', 'Organicos', 'basura.jpeg']
]

# Tamaño de la imagen
width, height = 1024, 896


for i, bloque in enumerate(lista):

  # Crear una imagen en blanco con fondo negro
  imagen = Image.new("RGB", (width, height), "black")

  # Convertir la imagen a RGBA
  imagen = imagen.convert('RGBA')

  attached_image = Image.open(f'imagenes/{bloque[3]}')

  image_size = attached_image.size

  imagen.paste(attached_image, ((width - image_size[0]) // 2, (height - image_size[1]) // 2))


  # Crear un objeto ImageDraw para dibujar en la imagen
  dibujo = ImageDraw.Draw(imagen)

  # Texto que se mostrará en el centro
  texto_centro = bloque[0]

  # Fuente y tamaño de fuente inicial para el texto
  tamanio_fuente_centro = 30
  fuente_centro = ImageFont.truetype('font.ttf', tamanio_fuente_centro)

  # Definir el ancho máximo para el texto del centro
  ancho_maximo_centro = width - 60

  # Función para dividir el texto en líneas que quepan en el ancho máximo
  def dividir_texto(texto, fuente, ancho_max):
    cadena_final = ""
    oraciones = texto.split('\n')
    for oracion in oraciones:
      palabras = oracion.split()
      lineas = []
      linea_actual = palabras[0]
      for palabra in palabras[1:]:
        if dibujo.textbbox((0, 0), linea_actual + " " + palabra, font=fuente)[2] <= ancho_max:
          linea_actual += " " + palabra
        else:
          lineas.append(linea_actual)
          linea_actual = palabra
      lineas.append(linea_actual)
      if oracion == oraciones[len(oraciones) - 1]:
        cadena_final += "\n".join(lineas)
      else:
        cadena_final += "\n".join(lineas) + "\n"
    return cadena_final

  # Función que agrega espacios al texto hasta que quepa en el ancho máximo y quede centrado en x
  def centrar_texto(texto, fuente, ancho_max):
    cadena_final = ""
    lineas = texto.split("\n")
    for linea in lineas:
      while dibujo.textbbox((0, 0), linea, font=fuente)[2] <= ancho_max:
        linea = " " + linea + " "
      cadena_final += linea + "\n"
    return cadena_final

  # Dividir el texto en líneas que quepan en el ancho máximo
  texto_centro = dividir_texto(
      texto_centro, fuente_centro, ancho_maximo_centro)
  
  # Centrar el texto en x
  texto_centro = centrar_texto(
      texto_centro, fuente_centro, ancho_maximo_centro)

  # Calcular el alto del cuadro del texto en función del número de líneas
  alto_texto_centro = len(texto_centro.split("\n")) * \
      (tamanio_fuente_centro + 5)

  # Calcular la posición para centrar el texto en la imagen
  x_centro = (width - ancho_maximo_centro) // 2
  y_centro = (20)

  # Crear una imagen transparente para el rectángulo
  rectangulo_transparente = Image.new(
    'RGBA', (width - 40, int(alto_texto_centro * 0.85)), (0, 0, 0, 128))
  
  # Crear un objeto ImageDraw para la imagen transparente
  dibujo_transparente = ImageDraw.Draw(rectangulo_transparente)

  # Dibujar el rectángulo en la imagen transparente
  dibujo_transparente.rectangle(
    (0, 0, width, alto_texto_centro), fill=(0, 0, 0, 128), outline=None)
  
  # Pegar la imagen transparente en la imagen original
  imagen.paste(rectangulo_transparente, (20, 10), mask=rectangulo_transparente)

  # Agregar el texto en el centro
  dibujo.multiline_text((x_centro, y_centro), texto_centro,
                        fill="white", font=fuente_centro, spacing=5)

  # Texto en las esquinas inferiores izquierda y derecha
  texto_esquina_izquierda = bloque[1]
  texto_esquina_derecha = bloque[2]

  # Fuente y tamaño de fuente para las esquinas
  tamanio_fuente_esquinas = 30
  fuente_esquinas = ImageFont.truetype('font.ttf', tamanio_fuente_esquinas)

# Cálculos
  bbox_izquierda = dibujo.textbbox((width - tamanio_fuente_esquinas, height -
                                  tamanio_fuente_esquinas), texto_esquina_izquierda, font=fuente_esquinas)
  x_esquina_izquierda = (bbox_izquierda[2] - bbox_izquierda[0]) + 20

  # Agrega un fondo negro detrás del texto de la esquina inferior izquierda
  dibujo.rectangle(
      (10, height - 60, 10 + x_esquina_izquierda, height - 10), fill="black")

  # Agregar el texto en la esquina inferior izquierda
  dibujo.text((20, height - 50), texto_esquina_izquierda,
              fill="white", font=fuente_esquinas)

  # Cálculos
  bbox_derecha = dibujo.textbbox((width - tamanio_fuente_esquinas, height -
                                tamanio_fuente_esquinas), texto_esquina_derecha, font=fuente_esquinas)
  x_esquina_derecha = width - (bbox_derecha[2] - bbox_derecha[0]) - 30

  # Agrega un fondo negro detrás del texto de la esquina inferior derecha
  dibujo.rectangle((x_esquina_derecha - 10, height - 60, width - 20, height - 10), fill="black")

  # Agregar el texto en la esquina inferior derecha
  dibujo.text((x_esquina_derecha, height - 50),
              texto_esquina_derecha, fill="white", font=fuente_esquinas)

  # Guardar la imagen generada
  imagen.save(f"imagen-{i}.png")

  # Mostrar la imagen generada
  # imagen.show()
