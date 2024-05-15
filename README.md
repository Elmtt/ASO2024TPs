A - Con respecto al tiempo de ejecucion de sinhilos.py no es predecible, en todas las pruebas que hice los segundos promediaban en 5.1 / 5.2
De igual manera conhilos.py los tiempos no eran predecibles, pero promediaban los 4.0 / 4.1 segundos.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
B - Luego de hacer la comparacion de tiempos con mis amigos, nos dimos cuenta que a todos nos da diferentes tiempos.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
C - En el primer codigo con # el tiempo de ejecucion es muy corto, esto debido a que el codigo no tiene bucles internos, los hilos interrumpen las operaciones de lectura y escritura de acumulador, lo que causa resultados incorrectos.
En el segundo codigo sin los #, for i in range(1000): suma una demora adicional que reduce la probabilidad de interferencia, haciendo que el programa funcione de una manera mas consistente.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
