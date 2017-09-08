Sistemas Operativos
===================

----

# Introducción
Los Sistemas Operativos son:
 - Interfaz usuario-máquina
 - Administradores de recursos: Toman decisiones para que haya un buen rendimiento
 - Conjunto de servicios: // TODO
 - Mecanismo de seguridad: Que los usuarios trabajen de forma segura, exista una buena persistencia de información y manejo de roles.

# Historia
### Década de los 50's
Se utilizaban máquinas dedicadas con una **única tarea** y no tenían almacenamiento.
Se conducían por medio de **tarjetas perforadas**.
Solo de podía ejecutar un trabajo a la vez, por lo que todo se reposaba sobre una cola. La salida era por medio de una sola pantalla, o por medio de cintas de papel.

Existían lenguajes de programación con sus bibliotecas de funciones. También los compiladores, sin embargo estas herramientas había que configurarlas cada ejecución de la computadora.

Nacen ciertas soluciones para mejorar el uso de los recursos y el tiempo.
1. Crear operadores
2. Crear lotes de trabajo: Reutiliza la configuración para jobs similares.
3. Automatizar el proceso de configuración

# Esquema Operativo
 - Monitor: Controla los recursos
 - Programa de Usuario: Utiliza los recursos para ejecutar programas.
```
╔═════════════════════╗
║       Monitor       ║ <──╗
╟─────────────────────╢    ║─ System Calls (Interrupciones)
║ Programa de usuario ║────╝
╚═════════════════════╝
```
#### Modos de ejecución
 - Privilegiado (root): Utiliza las funciones del monitor.
 - Usuario: Pide al monitor que le ejecute los cálculos por medio de interrupciones.

#### Multiprogramación
```
╔══════════╗────>╔═══════╗====>╔═════╗────>╔═════╗
║ Job Pool ║     ║ Ready ║     ║ Run ║     ║ End ║
╚══════════╝<~~~~╚═══════╝<----╚═════╝<────╚═════╝
   Disco            ^  ╔═════════╗  ║
                    ║  ║ Blocked ║<─╝
                    ╚──╚═════════╝
--- : Tiempo compartido        
=== : Cpu Scheduler        
~~~ : Job Scheduler (Swap)    
```

# Conceptos
 - Recurso: Procesador, memoria, dispositivos, usuarios, hardware.
 - Set-Up time: Lo que toma configurar la máquina para poder ejecutar un job.
 - Turn Around Time: Set-Up + El tiempo que toma ejecutándose hasta dar un resultado.
 - Waiting Time
 - Starvation: Cuando un proceso pueda no llegar a ser elegido por el CPU scheduler. Por que tiene muy baja prioridad o entran múltiples procesos más importantes.
 - Monoprogramación: Un programa se ejecuta a la vez.
 - Multiprogramación: Múltiples programas se ejecutana la vez.
 - Interrupción: Alteración en el flujo de procesamiento. Ejecutan código del S.O. Un tipo son las excepciones.
     ```
           p║
     int    ║
     ══════>SO══>
     ```
 - Job: Conjunto de instrucciones en memoria listas para ejecutar. Pertenece a un programa.
   - Job-Mix: Balance entre CPU/IO Bounding
   - CPU-Bound: El TAT pasa en en CPU
   - IO-Bound: Pasa la mayor parte del tiempo bloqueado.
   - Operaciones
       - Creación (fork): Un padre da vida a un hijo pero el hijo no tiene referencia al padre.
       - Destrucción: Requiere root. Se elimina proceso del heap.
         1. Buscar PCB
         2. Liberar memoria del proceso
         3. Liberar recursos I/O
         4. Borrar PCB
       - Comunicación
         - Mensajes
           - Comunicación
             - Directa: Ambos procesos se conocen
             - Indirecta: El que recibe no conoce al que envía
             - Sincrónica: El receptor espera el mensaje
             - Asincrónica: El receptor reacciona al recibir el mensaje.
           - Busy Waiting: Enciclarse esperando un mensaje
           - Buzones: Cola de atención de mensajes. Si la cola está llena, se pierde el mensaje.
   - Memoria compartida: Fragmento de memoria donde puede escribir un productor y leer un consumidor. Es muy veloz. Debe estar sincronizada.
   - Schedule
     - Job scheduler: Evaluación de prioridad a largo plazo. Se encarga de cambios Job Pool <---> Ready
     - Medium term: Se ejecuta si hay mal job-mix. Define swaps.
     - CPU scheduler: Es un job. Evalúa la prioridad de cual job pasar de Ready->Run. Se encarga de un buen TAT.
       - Context Switch
         1. Guarda el estado del proceso saliente
         2. Escoge el siguiente proceso
         3. Carga el estado del proceso entrante.
     - Burst: Tiempo que un proceso está en el CPU. El WT es el conjunto de todos los bursts.
       - IO Burst: Pequeño y no apropiativo
       - CPU Burst: Del tamaño de todo el time-slice.
     - Apropiativo: Se le arrebata el proceso al finalizar un time-slice.
     - No apropiativo: El proceso libera el recurso cuando lo necesite.
 - Algoritmos de Planificación: Buscan aumentar el porcentaje de uso del CPU y su eficiencia, y disminuir el TAT y WT.
   - FIFO: No starvation. Poco overhead. No es inteligente.
   - Short Job First: Elige el proceso con burst más pequeño. Tiene starvation. El burst es estimado.
   - Highest Priority First: Elige el proceso con mayor prioridad, basado en tipo, urgencia, recursos que use, origen. Tiene starvation.
   - RoundRobin: Evalúa prioridad al finalizar un quantum (cantidad de bursts contínuos). No starvation.
   - Colas Múltiples: Múltiples algoritmos agrupados para balancear la eficiencia.
   - Colas Múltiples Retroalimentadas

 - Memory states
     - Ready
     - Run
     - Blocked
     - Job pool (HDD)
     - End
 - Monitor
   - Overhead: Tiempo que tarda el SO en tomar decisiones administrativas.
   - Tiempo compartido: Da la sensación de correr múltiples procesos a la vez, pero solo distribuye el uso del cpu.
     - Time-slice: Fracción de tiempo definida para la ejecución de un fragmento de un job. Se define en cantidad de ciclos del CPU y se acaba por interrupciones físicas.
   - PCB (Process Central Block): Ficha de información de un proceso. Se crea en el paso de Job Pool --> Ready. Se usa para evaluar la prioridad en el CPU-Scheduler.
     - PID
     - Prioridad
     - Tamaño en memoria (bytes)
     - Registro base (inicio)
     - Memoria virtual
     - Estado (ready | run | blocked)
     - Tipo: User | Kernel
     - Archivos
     - Información temporal: WT, TAT, etc
     - Program Counter
     - Estado del CPU (registros)
   - Throughput: Cantidad de procesos terminados por unidad de tiempo. Medida de rendimiento.
   - Speed Up: Razón de mejora del rendimiento al incluir más procesadores.
   - DMA (Direct Memory Access): Buffer de memoria. Libera a la RAM pues descarga el programa en otro lugar.
     - Es hardware.
     - Permite la multiprogramación.
 - Discos
   - Partes
     - Plato
     - Pista
     - Sector
   - Tiempo de localización (seek): Ubicar la pista a leer
   - Tiempo de transferencia (transfer): // TODO
   - Administración de CPU
     - Proceso concurrente: Inicia su ejecución sin que otro proceso haya terminado.
     - Proceso cooperativo: Afecta la ejecución de otro proceso.
 - Sistemas
     - Tiempo Real: Enfocados en la exactitud de su resultado, no en su velocidad de respuesta.
       - Puede haber tiempo ocioso pues son dedicados a una sola tarea.
       - Soft: Baja importancia de exactitud. (juegos, streaming)
       - Strict: Alta importancia de exactitud. (medicina, aviones)
     - Paralelos: Cuando tienen n-procesadores, debe haber sincronización.
       - Fuertemente acoplados (Comparten recursos físicos)
       - Simétricos: Cada CPU corre su propio scheduler
       - Asimétricos: Esquema maestro/esclavo. CPU-Scheduler dedicado.
     - Distribuidos
       - Debilmente acoplados (máquinas separadas hasta con redes de por medio)
       - Tienen procesamiento compartido lo que aumenta el overhead y la eficiencia
       - Nodos dedicados a distintas tareas.
       - Mayores desventajas: Costo en tiempo de comunicación y riesgo de fallo físico.
 - [Sincronización](#Sincronización)
   - Características
   - Región Crítica
 - Semáforos
   - Son señales para indicar cuando se debe bloquear un proceso para esperar a que un recurso sea liberado para garantizar la integridad de los datos.
   - Tiene un valor numérico
   - Contienen una cola
   - Existen diferentes consultores
   - Funciones
     - Pedir:    p(s)
     - Devolver: v(s)
   - Debe haber un semáforo por cada recurso compartido
   - Rodean las regiones críticas
   - Tipos
     - Binarios: [-n,1]
     - Contadores: [-n,n]
   - Deadlock


---
# Definiciones

## Sincronización
Bloquea ciertos procesos para asegurar la correcta ejecución de un proceso.

### Características
1. **Exclusión Mutua**: Asegura que si un proceso se encuentra dentro de la región crítica, nadie más estará dentro de la región crítica.
2. **Progreso**: Todo proceso puede entrar en la región crítica si no hay otro en la región crítica.
3. **Espera Finita**: Todo proceso que deba esperar por un recurso, se le asignará el recurso eventualmente.

#### Región Crítica
Segmento de código capaz de colisionar en ejecución con otro proceso.
 - Debe ser lo más pequeña posible.
 - Existe una por cada recurso compartido
 - Se abre con un *epilogo* y se cierra con un *prólogo*. Esto son fragmentos de código que se ejecutan antes y después de la región para señalar el estado.
     ``` c
    // Sincronicación básica
    //   Falla si el segundo proceso se ejecuta antes que el primero
    turn = 0;
    while(turn != 0); // Epílogo
    RC                // Región crítica
    turn = 1;         // Prólogo
     ```
     ``` c
    // Modo 2 xdxdxd
    flag[2] = {0,0}

    flag[0] = 1       // Quiero entrar a RC
    while(turn != 0); // Epílogo
    RC                // Región crítica
    flag[0] = 0;      // Prólogo
     ```
     ``` c
    // Modo 3 xdxdxd
    // Aplica solo para 2 procesos
    flag[2] = {0,0}

    flag[0] = 1;                      // Quiero entrar a RC
    turn = 1;
    while(flag[1] != 0 && turn == 1); // Epílogo
    RC                                // Región crítica
    flag[0] = 0;                      // Prólogo
     ```

## Relación Productor-Consumidor

- Semáforo: Comunicación
- Se utiliza un semáforo por cada recurso a utilizar.

#### Recursos
- Líneas vacías
- Líneas llenas

#### Productor
Escribe en el buffer, en una **línea vacía**.

#### Consumidor
Lee del buffer, de una **línea llena**.
```
╔═══════════╗     ╔════════╗     ╔════════════╗
║ Productor ║────>║ Buffer ║────>║ Consumidor ║
╚═══════════╝     ╚════════╝     ╚════════════╝
```
```
// Productor            Consumidor
P(lineasVacias)      P(lineasLlenas)         
produce              consume
V(lineasLlenas)      V(lineasVacias)         
```

## Relación Reader-Writer

- Semáforo: Comunicación
- Se utiliza un semáforo por cada recurso a utilizar.

#### Recursos
- Líneas vacías
- Líneas llenas

#### Productor
Escribe en el buffer, en una **línea vacía**.

#### Consumidor
Lee del buffer, de una **línea llena**.
```
╔═══════════╗                     ╔════════════╗
║ Productor ║──╗              ╔──>║ Consumidor ║
╚═══════════╝  ║              ║   ╚════════════╝
╔═══════════╗  ╚─>╔═════════╗─╝   ╔════════════╗
║ Productor ║────>║ Archivo ║────>║ Consumidor ║
╚═══════════╝  ╔─>╚═════════╝─╗   ╚════════════╝
╔═══════════╗  ║              ║   ╔════════════╗
║ Productor ║──╝              ╚──>║ Consumidor ║
╚═══════════╝                     ╚════════════╝
```
```
// Writer       Reader
P(archivo)      P(mutex)         
escribe         inc(cont)
V(archivo)      if(cont == 1)
                  P(archivo)
                V(mutex)
                leer
                P(mutex)
                dec(cont)
                if(cont == 0)
                  V(archivo)
                V(mutex)
```

T_n = alfa t_n-1 + (1-alfa) T_n-1

alfa = 0.6
T_0 = 10
t = {8,10,4,6,5}

```
t       8
---------------
T   10  8.8

```
