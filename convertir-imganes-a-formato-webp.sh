#!/bin/bash

# Instrucciones:
# Ejecuta los Siguientes comandos:
# sudo apt install webp
# chmod +x ./convertImagesToWebp.sh


# Solicitar al usuario que ingrese la ruta del directorio de imágenes
read -p "Por favor, ingrese la ruta del directorio de imágenes: " DIRECTORIO

# Verificar si el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
  echo "El directorio $DIRECTORIO no existe."
  exit 1
fi

# Iterar sobre cada archivo de imagen en el directorio
for archivo in "$DIRECTORIO"/*; do
  # Verificar si el archivo es una imagen con una extensión válida
  if [[ "$archivo" == *.jpg || "$archivo" == *.jpeg || "$archivo" == *.png ]]; then
    # Obtener el nombre del archivo sin la extensión
    nombre_sin_extension=$(basename "$archivo" | cut -d. -f1)
    # Ejecutar el comando cwebp para convertir el archivo a WebP
    cwebp "$archivo" -o "${DIRECTORIO}/${nombre_sin_extension}.webp"
    # Imprimir mensaje de conversión exitosa
    echo "La imagen ${nombre_sin_extension} ha sido convertida a ${nombre_sin_extension}.webp"
  fi
done

# Verificar si no se encontraron archivos de imagen en el directorio
if [ $(ls -1 "$DIRECTORIO"/*.{jpg,jpeg,png} 2>/dev/null | wc -l) -eq 0 ]; then
  echo "No se encontraron archivos de imagen en el directorio $DIRECTORIO"
fi
