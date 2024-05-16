A - Con respecto al tiempo de ejecucion de sinhilos.py no es predecible, en todas las pruebas que hice los segundos promediaban en 5.1 / 5.2
De igual manera conhilos.py los tiempos no eran predecibles, pero promediaban los 4.0 / 4.1 segundos.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
B - Luego de hacer la comparacion de tiempos con mis amigos, nos dimos cuenta que a todos nos da diferentes tiempos.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
C - En el primer codigo con # el tiempo de ejecucion es muy corto, esto debido a que el codigo no tiene bucles internos, los hilos interrumpen las operaciones de lectura y escritura de acumulador, lo que causa resultados incorrectos.
En el segundo codigo sin los #, for i in range(1000): suma una demora adicional que reduce la probabilidad de interferencia, haciendo que el programa funcione de una manera mas consistente.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h> // para usar intptr_t

#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20

int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
pthread_mutex_t lock; // Mutex para controlar el acceso a la variable compartida
int turno = 0; // Variable para el turno de acceso

void *comer_hamburguesa(void *tid)
{
    int id = (intptr_t) tid;
    while (1)
    {
        // Esperar al turno
        while (turno != id)
        {
            // Pequeña pausa para evitar consumir recursos innecesarios
            sched_yield();
        }

        pthread_mutex_lock(&lock); // Bloquear la sección crítica
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! soy el hilo (comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", id, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // me como una hamburguesa
        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
            pthread_mutex_unlock(&lock); // Desbloquear antes de salir de la función
            pthread_exit(NULL); // forzar terminacion del hilo
        }
        turno = (turno + 1) % NUMBER_OF_THREADS; // Cambiar el turno
        pthread_mutex_unlock(&lock); // Desbloquear la sección crítica
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, ret;
    pthread_mutex_init(&lock, NULL); // Inicializar el mutex
    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)(intptr_t)i);
        if (status != 0)
        {
            printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
            exit(-1);
        }
    }

    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        ret = pthread_join(threads[i], NULL); // espero por la terminacion de los hilos que cree
        if (ret != 0)
        {
            printf("Error al esperar la terminación del hilo %d, código de error %d \n", i, ret);
        }
    }

    pthread_mutex_destroy(&lock); // Destruir el mutex
    printf("Todos los hilos han terminado. Adios!\n");
    return 0; // Finalizar el programa
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
