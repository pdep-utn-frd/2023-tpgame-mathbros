from PIL import Image, ImageDraw, ImageFont
import textwrap
from narrativa import lista

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
