#!/bin/bash

# Variable para verificar la entrada de una cadena válida
entrada_valida=0 

echo "Parte 2 - Edad estimada según el nombre"

read -p "Por favor, introduzca un nombre: " nombre

# Ciclo while para asegurar que se ingrese un nombre válido
while [ "$entrada_valida" -eq 0 ];
do
    if [[ -z "$nombre" ]];
    then
        echo "Debe ingresar un nombre válido. Inténtelo de nuevo:"
        entrada_valida=0    
        read nombre
    else
        entrada_valida=1            
    fi
done

# La variable 'respuesta' guarda los datos proporcionados por la API para el nombre ingresado
respuesta=$(curl -s "https://api.agify.io/?name=$nombre")

# La variable 'edad' contendrá la edad estimada obtenida de la respuesta JSON
edad=$(echo $respuesta | grep -o '"age":[^,]*' | grep -o '[0-9]\+')

# Verificación de los datos devueltos por la API
if [ -n "$edad" ]; 
then
    echo "La edad promedio para el nombre '$nombre' es: $edad años."
else
    echo "No se encontraron datos para el nombre '$nombre'."
fi
