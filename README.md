# Versión en español

# Teleporter

Esta es una guía de Teleporter en Español.

# Flujo de interacción entre contratos

## Contratos Desacomplados

La lógica planteada en estos contratos implica la conección secuencial entre tres contratos, dos de ellos están en la subnet de origen y el otro está en la subnet de destino.
Tenemos dos tipos de flujos de `Dispatch` a `C-Chain`, y de `C-Chain` a `Dispatch`.

-   La subnet de origen tiene dos contratos, uno llamado Origin y otro llamado sender.
-   La subnet de destino tiene un contrato llamado receiver.
-   Se agregan sufijos inficando el flujo de desacoplado `Disengaged`.
-   Se agregan sufijos indicando el sentido `DC` quiere decir de `Dispatch` a `C-Chain`.

## Contratos Simples

La lógica planteada en estos contratos implica la conección entre dos contratos, uno de ellos está en la subnet de origen y el otro está en la subnet de destino.
Tenemos dos tipos de flujos de `Dispatch` a `C-Chain`, y de `C-Chain` a `Dispatch`.

-   La subnet de origen tiene un contrato, uno llamado `Sender`.
-   La subnet de destino tiene un contrato llamado `Receiver`.
-   Se agregan sufijos indicando el sentido `DC` quiere decir de `Dispatch` a `C-Chain`.

## Acción

Estos contratos buscan mandar un mensaje de tipo `String` de una subnet de Origen a una de destino.

## Flujo Contratos Desacomplados

Para desplegar todos los contratos y asegurar una correcta comunicación entre las partes, es requerido desplegar en el siguiente orden y ejecutar las siguientes funciones:

1. Desplegar en la subnet de origen el contrato `Origin`.
2. Desplegar en la subnet de origen el contrato `Sender` enviandole como argumento la dirección del contrato de `teleporterRegistryAddress` el cual es el mismo para la subnet `Dispatch` y `C-Chain` y lo pueden encontrar en `.env.example`.
3. Desplegar en la subnet de destino el contrato `Receiver` enviando como argumento la dirección del contrato de `teleporterRegistryAddress` el cual es el mismo para la subnet `Dispatch` y `C-Chain` y lo pueden encontrar en `.env.example`.
4. Una vez están todos los contratos desplegados, podemos enviar mensajes, para esto en la subnet de origen, en el contrato `Origin` llamamos la función `sendMessage` enviando como argumento el mensaje que queremos enviar a la subnet de destino, la dirección del contrato de `Sender` y la dirección del contrato `Receiver` que está en la subnet de destino.

## Flujo Contratos Simples

Para desplegar todos los contratos y asegurar una correcta comunicación entre las partes, es requerido desplegar en el siguiente orden y ejecutar las siguientes funciones:

1. Desplegar en la subnet de origen el contrato `Sender` enviandole como argumento la dirección del contrato de `teleporterRegistryAddress` el cual es el mismo para la subnet `Dispatch` y `C-Chain` y lo pueden encontrar en `.env.example`.
2. Desplegar en la subnet de destino el contrato `Receiver` enviando como argumento la dirección del contrato de `teleporterRegistryAddress` el cual es el mismo para la subnet `Dispatch` y `C-Chain` y lo pueden encontrar en `.env.example`.
3. Una vez están todos los contratos desplegados, podemos enviar mensajes, para esto en la subnet de origen, en el contrato `Sender` llamamos la función `sendMessage` enviando como argumento la dirección del contrato `Receiver` que está en la subnet de destino y el mensaje que queremos enviar a la subnet de destino.

# Hazlo tu mismo

Para probar este código primero deberás crear un archivo llamado `.env`, en este crearemos una variable llamada `MNEMONIC` la cual será la frase semilla de una billetera que tenga tokens de `Avax` en `C-Chain` y `Dispatch`; así como la variable `teleporterRegistryAddress` que puedes encontrar en `.env.example`.

El archivo se vera así:

`MNEMONIC = hola como estas palabra4 palabra5 palabra6 hola como estas palabra10 palabra11 palabra12`
`teleporterRegistryAddress = 0xEeeAA8e0e25802A3748Cd7FbFA96b851E76DFF9b`

Luego deberás correr los scripts en el siguiente orden:

1. `npm i` (Instala las dependencias necesarias).
2. `npm run compile` (Compila y crea los tipos necesarios según los contratos).
3. `npm run deploy_simple` (Despliega los contratos de la subnet de origen y de destino).
4. `npm run review_simple` (Valida el valor del mensaje en la subnet de destino, manda el mensaje hola desde la subnet de origen y vuelve a preguntar por el valor del mensaje en la subnet de destino, mostrando un nuevo valor producto del uso de Teleporter).

Nota: Si queremos probar el flujo desacoplado llamamos `deploy_disengaged` y `review_disengaged`.
Si queremos probar los flujos de `Dispatch` a `C-Chain` llamamos lo anterior mencionado pero ponemos el sufijo `_dc`.

# English version

# Teleporter

This is a Teleporter guide in English.

# Interaction Flow between Contracts

## Disengaged Contracts

The logic implemented in these contracts involves sequential connection between three contracts, two of them are in the source subnet and the other one is in the destination subnet. We have two types of flows from `Dispatch` to `C-Chain`, and from `C-Chain` to `Dispatch`.

-   The source subnet has two contracts, one called Origin and another one called sender.
-   The destination subnet has a contract called receiver.
-   Suffixes indicating the disengaged flow `Disengaged` are added.
-   Suffixes indicating the direction are added `DC` means from `Dispatch` to `C-Chain`.

## Simple Contracts

The logic implemented in these contracts involves the connection between two contracts, one of them is in the source subnet and the other one is in the destination subnet.
We have two types of flows from `Dispatch` to `C-Chain`, and from `C-Chain` to `Dispatch`.

-   The source subnet has a contract, called `Sender`.
-   The destination subnet has a contract called `Receiver`.
-   Suffixes indicating the direction are added `DC` means from `Dispatch` to `C-Chain`.

## Action

These contracts aim to send a message of type `String` from a source subnet to a destination subnet.

## Disengaged Contracts Flow

To deploy all the contracts and ensure proper communication between the parties, it is required to deploy in the following order and execute the following functions:

1. Deploy the `Origin` contract in the source subnet.
2. Deploy the `Sender` contract in the source subnet, passing the address of the `teleporterRegistryAddress` contract as an argument, which is the same for the `Dispatch` and `C-Chain` subnets and can be found in `.env.example`.
3. Deploy the `Receiver` contract in the destination subnet, passing the address of the `teleporterRegistryAddress` contract as an argument, which is the same for the `Dispatch` and `C-Chain` subnets and can be found in `.env.example`.
4. Once all contracts are deployed, we can send messages. For this, in the source subnet, in the `Origin` contract, we call the `sendMessage` function passing as arguments the message we want to send to the destination subnet, the address of the `Sender` contract, and the address of the `Receiver` contract in the destination subnet.

## Simple Contracts Flow

To deploy all the contracts and ensure proper communication between the parties, it is required to deploy in the following order and execute the following functions:

1. Deploy the `Sender` contract in the source subnet, passing the address of the `teleporterRegistryAddress` contract as an argument, which is the same for the `Dispatch` and `C-Chain` subnets and can be found in `.env.example`.
2. Deploy the `Receiver` contract in the destination subnet, passing the address of the `teleporterRegistryAddress` contract as an argument, which is the same for the `Dispatch` and `C-Chain` subnets and can be found in `.env.example`.
3. Once all contracts are deployed, we can send messages. For this, in the source subnet, in the `Sender` contract, we call the `sendMessage` function passing as arguments the address of the `Receiver` contract in the destination subnet and the message we want to send to the destination subnet.

# Do it yourself

To test this code you must first create a file named `.env`, in this file we will create a variable called `MNEMONIC` which will be the seed phrase of a wallet that has tokens of `Avax` in `C-Chain` and `Dispatch`; as well as the variable `teleporterRegistryAddress` which you can find in `.env.example`.

The file will look like this:

`MNEMONIC = hello how are you word5 word6 hello how are you word10 word11 word12`
`teleporterRegistryAddress = 0xEeeAA8e0e25802A3748Cd7FbFA96b851E76DFF9b`

Then you must run the scripts in the following order:

1. `npm i` (Installs necessary dependencies).
2. `npm run compile` (Compiles and creates necessary types according to the contracts).
3. `npm run deploy_simple` (Deploys contracts from the source subnet and destination subnet).
4. `npm run review_simple` (Validates the message value in the destination subnet, sends the message hello from the source subnet, and asks again for the message value in the destination subnet, showing a new value resulting from the use of Teleporter).

Note: If we want to test the disengaged flow we call `deploy_disengaged` and `review_disengaged`.
If we want to test the `Dispatch` to `C-Chain` flows we call the aforementioned but append the suffix `_dc`.
