A - Con respecto al tiempo de ejecucion de sinhilos.py no es predecible, en todas las pruebas que hice los segundos promediaban en 5.1 / 5.2
De igual manera conhilos.py los tiempos no eran predecibles, pero promediaban los 4.0 / 4.1 segundos.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
B - Luego de hacer la comparacion de tiempos con mis amigos, nos dimos cuenta que a todos nos da diferentes tiempos.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
C - En el primer codigo con # el tiempo de ejecucion es muy corto, esto debido a que el codigo no tiene bucles internos, los hilos interrumpen las operaciones de lectura y escritura de acumulador, lo que causa resultados incorrectos.
En el segundo codigo sin los #, for i in range(1000): suma una demora adicional que reduce la probabilidad de interferencia, haciendo que el programa funcione de una manera mas consistente.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20
int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0; // Esta variable se utilizará para controlar el turno de cada comensal.

void *comer_hamburguesa(void *tid)
{
	while (1 == 1)
	{ 
        // INICIO DE LA ZONA CRÍTICA
        while(turno!=(int)tid); // Espera activa hasta que sea su turno
        // Incrementa el turno
        turno = (turno + 1)% NUMBER_OF_THREADS;
		if (cantidad_restante_hamburguesas > 0)
		{
			printf("Hola! soy el hilo(comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", (int) tid, cantidad_restante_hamburguesas);
			cantidad_restante_hamburguesas--; // me como una hamburguesa
		}
		else
		{
			printf("SE TERMINARON LAS HAMBURGUESAS :( \n");

			pthread_exit(NULL); // forzar terminacion del hilo
		}
        // SALIDA DE LA ZONA CRÍTICA   
	}
}

int main(int argc, char *argv[])
{
	pthread_t threads[NUMBER_OF_THREADS];
	int status, i, ret;
	for (int i = 0; i < NUMBER_OF_THREADS; i++)
	{
		printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
		status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)i);
		if (status != 0)
		{
			printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
			exit(-1);
		}
	}

	for (i = 0; i < NUMBER_OF_THREADS; i++)
	{
		void *retval;
		ret = pthread_join(threads[i], &retval); // espero por la terminacion de los hilos que cree
	}
	pthread_exit(NULL); // como los hilos que cree ya terminaron de ejecutarse, termino yo tambien.
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
