# Teleporter

Esta es una guía de Teleporter en Español

# Flujo de interacción entre contratos

La lógica planteada en estos contratos implica la conección en cadena entre los cuatro, dos de ellos están en la subnet de Amplify que de ahora en adelante llamaremos `subnet_a` y los otros dos están en Bulletin que de ahora en adelante llamaremos `subnet_b`.

- La `subnet_a` es la subnet de origen, que en este caso tiene un contrato llamado `SuperCalculator`, el cual suma y entrega un resultado dentro de la `subnet_a` y llama a un contrato de `TeleporterSender`, que interactúa con otro en la `subnet_b`, este contrato `TeleporterReceiver` en la subnet de destino, interactúa con otro contrato con lógica definida en dicha `subnet_b`, este contrato se llama `UltraCalculator`, el cual solo ejecuta dicha función si viene del owner del contrato o del contrato de `TeleporterReceiver` de su subnet, a su vez, el contrato de `TeleporterReceiver` en la `subnet_b` solo se ejecuta si se le definió previamente una dirección de un contrato `TeleporterSender` proveniente de la `subnet_a`, este contrato de `TeleporterSender` en la `subnet_a` también está anclado a la dirección del contrato `SuperCalculator` en su subnet.

- Para desplegar todos los contratos y asegurar una correcta comunicación entre las partes, es requerido desplegar en el siguiente orden y ejecutar las siguientes funciones.

1. Desplegar en la `subnet_a` el contrato `SuperCalculator`.
2. Desplegar en la `subnet_a` el contrato `TeleporterSender` enviandole como argumento la dirección del contrato de `SuperCalculator` que se desplegó en el paso anterior en la `subnet_a`.
3. Desplegar en la `subnet_b` el contrato `TeleporterReceiver` enviando como argumento la dirección del contrato de `TeleporterSender` que se desplegó en el paso anterior en la `subnet_a`.
4. Desplegar en la `subnet_b` el contrato `UltraCalculator` enviando como argumento la dirección del contrato de `TeleporterReceiver` que se desplegó en el paso anterior en la `subnet_b`.
5. En la `subnet_b`, en el contrato `TeleporterReceiver` llamar la función `updateUltraCalculator` enviando como argumento la dirección del contrato de `UltraCalculator` que se desplegó en el paso anterior en la `subnet_b`.
6. En la `subnet_a`, en el contrato `TeleporterSender` llamar la función `updateTeleporterReceiverAddress` enviando como argumento la dirección del contrato de `TeleporterReceiver` que se desplegó en el paso `3` en la `subnet_b`.
7. En la `subnet_a`, en el contrato `SuperCalculator` llamar la función `updateSender` enviando como argumento la dirección del contrato de `TeleporterSender` que se desplegó en el paso `2` en la `subnet_a`.

# Flujo de prueba

Para probar este código primero deberás crear un archivo llamado `.env`, en este crearemos una variable llamada `MNEMONIC` la cual será la frase semilla de una billetera que tenga tokens de `Amplify`, `Bulletin` y tokens de `TP`(Teleporter) en ambas redes.

El archivo se vera así:

`MNEMONIC = hola como estas palabra4 palabra5 palabra6 hola como estas palabra10 palabra11 palabra12`

Luego deberás correr los scripts en el siguiente orden:

1. `npm i` (Instala las dependencias necesarias)
2. `npm run compile` (Compila y crea los tipos necesarios según los contratos).
3. `npm run deploy1` (Despliega los contratos de la `subnet_a`).
4. `npm run deploy2` (Despliega los contratos de la `subnet_b` y llama la función del paso `5` mencionado en la sección anterior).
5. `npm run deploy3` (Llama la función del paso `6` y `7` mencionado en la sección anterior correspondientes a la `subnet_a`).
6. `npm run validate_operation` (Llama la función `result` de `UltraCalculator` en la `subnet_b`, la cual retorna un valor inicial de `0`, lo que significa que su valor está inicializado y no se ha modificado).
7. `npm run run_operation` (Llama la función `sumTwoNumbers` de `SuperCalculator` en la `subnet_a`, la cual suma e inicia una llamada en cascada hasta llegar al contrato de `UltraCalculator` en la `subnet_b`).
8. `npm run validate_operation` (Llama la función `result` de `UltraCalculator` en la `subnet_b`, la cual retorna un valor diferente a `0`, lo que significa que su valor se modificó conforme a lo asignado en el contrato de `SuperCalculator` en la `subnet_a`).
