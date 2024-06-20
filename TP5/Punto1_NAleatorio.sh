#!/bin/bash
numero_aleatorio=$((1 + $RANDOM % 100))
adivinado=0
echo "Parte 1 - Juego de adivinanza de número aleatorio"
echo "Ingrese un número para comenzar a adivinar y se le dirá si el número ingresado es mayor o menor que el número aleatorio."

while [ "$adivinado" -eq 0 ];
do
    read intento
    numero_ingresado=$intento
    if [[ "$numero_ingresado" -gt "$numero_aleatorio" ]];
        then
            echo "El número ingresado es mayor."
        elif [[ "$numero_ingresado" -eq "$numero_aleatorio" ]];
            then
                echo "¡Excelente! ¡Has encontrado el número correcto!"
                adivinado=1
            else
                echo "El número ingresado es menor."
            fi
done
