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
Se utilizaban máquinas dedicadas con una __única tarea__ y no tenían almacenamiento.
Se conducían por medio de __tarjetas perforadas__.
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
   - Deadlock: Es impredecible
     - Se da cuando hay n procesos con m recursos y de alguna forma ocurrió.
     - Condiciones necesarias para que ocurra un deadlock:
       - Exclusión mutua: Debido al bloqueo de los procesos.
       - Hold and wait: cuando un proceso retiene los recursos que ya tiene mientras espera por otros.
       - No-Apropiativo: El recurso
       - Espera circular: Los procesos dependen entre si de manera circular.
     - Acciones para manejarlos
       - __Técnica del avestruz__: ignorar los deadlocks. El usuario se hace responsable de sus propios deadlocks.
       - __Prevención__: Nunca ocurre un deadlock si se aplica esta técnica. Consiste en eliminar alguna de las condiciones.
         - Exclusión mutua: No se puede elimiar pues es un principio de la sicronización.
         - Hold and wait
           1. Recursos a priori: Entregar todos los recursos desde el inicio. Esto es poco eficiente, no asegura el progreso del proceso y se da subutilización de recursos. Da pie a starvation porque puede que nunca estén disponibles sus recursos necesarios.
           2. Devolver un recurso para usar otro: Más posible, pero no sirve en todos los casos, pues a veces se requieren múltiples recursos simultáneamente.
         - No apropiativo
           - Un recurso apropiativo implica que se requiera guardar el estado antes de apropiarme de él.
           - No todos los recursos son apropiativos.
         - Espera circular: Quitar ciclos a la hora de pedir recursos. Se hace con una asignación jerárquica de recursos que establece un tipo de recursos para todo lo que un proceso pueda pedir. A los procesos solo se les dan los recursos de un tipo mayor al que tengan.
       - __Evasión__: Vivimos con el deadlock, pero evitamos todo lo que se le parezca.
         - Cuando procesos piden recursos, simula la entrega de recursos para predecir si puede suceder un deadlock.
         - Algoritmo del banquero
           1. Petición de recursos
           2. Simulación de entrega de recursos donde evalúa si todos los procesos pueden terminar con tal petición, para así dejar al SO en un estado seguro.
         - Esta simulación conlleva a demasiado overhead.
       - __Detección__: Puede ocurrir el deadlock y se detecta
       - __Recuperación__:



---
# Definiciones

## Sincronización
Bloquea ciertos procesos para asegurar la correcta ejecución de un proceso.

### Características
1. __Exclusión Mutua__: Asegura que si un proceso se encuentra dentro de la región crítica, nadie más estará dentro de la región crítica.
2. __Progreso__: Todo proceso puede entrar en la región crítica si no hay otro en la región crítica.
3. __Espera Finita__: Todo proceso que deba esperar por un recurso, se le asignará el recurso eventualmente.

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
Escribe en el buffer, en una __línea vacía__.

#### Consumidor
Lee del buffer, de una __línea llena__.
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
Escribe en el buffer, en una __línea vacía__.

#### Consumidor
Lee del buffer, de una __línea llena__.
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

---

## Administración de Memoria
1. MultiProgramming with Fixed Tasks (MFT)
1. MFT Dinámico
3. Particiones dinámicas
 - No importa el tipo de proceso
 - Se asigna según petición
 - Se van creando espacios (huecos) en la memoria para asignarlos
 - Partición: [registroBase,registroLimite] almacenado en el PCB
 - Selección de espacio:
   - First-Fit: Selecciona el primer espacion con memoria suficiente.
   - Best-Fit: Selecciona donde se desperdicie la menor cantidad de memoria.
   - Worst-Fit: En el espacio más grande. Otros procesos pueden aprovechar el espacio libre.

#### Fragmentación
Cuando existen separaciones entre espacios asignados de memoria. Un espacio libre demasiado pequeño es muerto pues es atípico que un proceso quepa en tal espacio. Cuando existen muchos de estos espacios, se está desperdiciando memoria.

##### Tipos
- Externa: Cuando el espacio libre está entre particiones asignadas.
- Interna: Cuando el espacio libre está dentro de una partición. Este espacio libre no puede ser asignado a nadie más.

##### Solución
La __Compactación__ o (burping) consiste en reacomodar los procesos sobre la memoria para

## Paginación
__Objetivo__: Que un proceso no necesite estar contínuo para poder estar en memoria.
Tiene un tamaño de página
La cantidad de páginas que requiere un proceso es la cantidad de memoria/tamaño de página.

Dado un tamaño de página de 100, se tiene un proceso de 283 bytes. Por lo tanto 283/100=3. Debido a esto, las primeras dos páginas estarán llenas y la tercera quedará fragmentada. Esto ocasiona fragmentación interna.
El resultado son 3 páginas lógicas, que son las divisiones de un proceso y 3 páginas físicas que son los espacios en memoria donde se ubican realmente las páginas. Para ello se efecuta un mapeo de páginas físicas y lógicas

Este mapeo se efectúa en la tabla de páginas, que se almacena en la memoria. Es administrada por la Memory Management Unit (MMU). Esta se encarga de resolver las direcciones físicas de memoria al acceder a algún espacio en memoria del proceso.

TLB: Caché para tabla de páginas

## Memoria virtual
Permite reservar un espacio del disco --> Es la memoria principal
- Premite que un proceso no necesite estar completo en memoria para poderse ejecutar. Se almacena en memoria virtual una o varias páginas del proceso, para tener en memoria física solo las páginas requeridas para ejecutar un proceso en determinado momento. De esta manera se pueden ejecutar más procesos en memoria aunque sean de gran tamaño.

### Paginación por *demanda*
Al ejecutar un proceso, se cargan todas las páginas del proceso a memoria virtual. Con paginación por demanda, se permite solo subir a memoria física las páginas que el proceso necesite.
- __Demanda pura__: Cuando un proceso empieza sin tener ninguna página en memoria.
- __Page fork__: Cuando un proceso requiere una página que está en memoria virtual y la carga a memoria física.
- __Overlapping__: Intercambio de páginas de memoria física a virtual
- __Page Fault__: Cuando el sistema operativo no encuentra una página en memoria virtual.
```
// Qué sucede al haber un page fault
╔═════════════════╗       ╔════╗
║ PagLog | offset ║   ╔═══║ SO ║════╗3
╚═════════════════╝   ║   ╚════╝    v
   1║  ╔════════════╗ ║    ╔════════════╗
    ╚═>║ Page Table ║═╝2   ║ Page Table ║
<══════╚════════════╝      ╚════════════╝
    6       ^                      4║ ^
            ║                       ║ |4a
           5║    ╔════════════╗     ║ |
            ╚════║ MemoriaFís ║<════╝ |
                 ╚════════════╝-------╝
1: Pide página de proceso
2: Page Fault
3: Buscar en disco
4: Subir a memoria
4a. Bajar página
5: Actualizar tabla de páginas
6: Reinicia instrucción
```

AMT = p * pt + (1-p) * vmt
p: probabilidad de pageFault
pt: pageFault time
AMT: Tiempo de acceso a memoria
vmt: Tiempo promedio de acceso a memoria
