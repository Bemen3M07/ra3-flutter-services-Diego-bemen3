# buses

Aplicación Flutter para buscar buses por código de parada.

## Estructura

- `lib/main.dart`: punto de entrada de la aplicación.
- `lib/page/search_page.dart`: UI principal con campo de búsqueda y resultados.
- `lib/service/bus_service.dart`: cliente HTTP para consultar la API (URL placeholder).
- `lib/model/`: modelos de datos utilizados en la aplicación.

## Uso

1. Actualiza el `baseUrl` en `bus_service.dart` a la API real.
2. Ejecuta `flutter pub get`.
3. Corre la app (`flutter run`).
4. Ingresa el código de la parada y presiona "Buscar" para ver
   las líneas y los minutos restantes para cada bus.

La API aún debe ser provista; el modelo espera un JSON con
`linies_trajectes` tal como se describe en los comentarios de `model_bus.dart`.
