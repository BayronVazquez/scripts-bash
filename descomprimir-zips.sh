#!/bin/bash

# Solicitar la ruta
read -rp "Ingrese la ruta del directorio: " DIRECTORIO

# Verificar que exista
if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: El directorio no existe."
    exit 1
fi

# Verificar que unzip esté instalado
if ! command -v unzip >/dev/null 2>&1; then
    echo "Error: El comando 'unzip' no está instalado."
    exit 1
fi

# Habilitar glob vacío
shopt -s nullglob

ARCHIVOS=("$DIRECTORIO"/*.zip)

# Verificar si hay archivos ZIP
if [ ${#ARCHIVOS[@]} -eq 0 ]; then
    echo "No se encontraron archivos .zip en el directorio."
    exit 0
fi

# Descomprimir cada ZIP
for ZIP in "${ARCHIVOS[@]}"; do
    NOMBRE=$(basename "$ZIP" .zip)
    DESTINO="$DIRECTORIO/$NOMBRE"

    echo "Descomprimiendo: $(basename "$ZIP")"

    mkdir -p "$DESTINO"
    unzip -o "$ZIP" -d "$DESTINO"

    if [ $? -eq 0 ]; then
        echo "✔ Completado: $DESTINO"
    else
        echo "✘ Error al descomprimir: $(basename "$ZIP")"
    fi

    echo "----------------------------------------"
done

echo "Proceso finalizado."
