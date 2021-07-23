# CarRider

Una Aplicacion desarrollada en Ruby.


## Instalación

  - Crear base de datos vacia car_riders en PosgreSQL con las credenciales que desees.
  - Ejecutar: `bundle install`
  - Ejecutar: `sequel -m db/migrations postgres://username:password@localhost:port/car_riders`
  - Crear archivo `.env` en el directorio raiz del proyecto, con las siguinetes variables de entorno:
    ```bash
        export WOMPI_PUBLIC_KEY=pub_test_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        export WOMPI_PRIVATE_KEY=prv_test_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        export HOST=localhost
        export PORT=XXXX
        export DATABASE=car_riders
        export USER=XXXXX
        export PASSWORD=XXXXXX
    ```
  - Ejecutar el servidor: `dotenv -f ".env" rackup config.ru`

   
## Probar Endpoints

Para probar los endpoints hay que seguir los siguientes pasos:


### Registrar metodo de pago

- Path:  http://localhost:9292/v1/riders/1/create-payment-method
- Method: POST
- Body: 
  ```json
    {
        "number": "4242424242424242",
        "cvc": "123",
        "exp_month": "08",
        "exp_year": "28",
        "card_holder": "José Pérez"
    }
  ```


### Registrar compra

- Path:  http://localhost:9292/v1/riders/1/request-ride
- Method: POST
- Body: 
  ```json
    {
        "lng": "-72.07348141698203",
        "lat": "4.81312619298383"
    }
  ```


### Finalizar viaje

- Path:  http://localhost:9292/v1/rides/1/finish-ride
- Method: PUT
- Body: 
  ```json
    {
        "payment_method_id": 1
    }
  ```
