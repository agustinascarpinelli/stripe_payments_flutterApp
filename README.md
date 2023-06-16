# StripePayments

StripePayments es una aplicación de ejemplo que permite realizar pagos utilizando la pasarela de pagos Stripe. La aplicación te permite seleccionar una tarjeta guardada, agregar una nueva tarjeta o pagar con Google Pay.

## Capturas de pantalla

_Puedes agregar capturas de pantalla de tu aplicación aquí._

## Características

- Selección de tarjeta guardada
- Agregar una nueva tarjeta
- Pago con Google Pay

## Dependencias

Las dependencias utilizadas en este proyecto son:

- [bloc](https://pub.dev/packages/bloc) (versión 8.1.1)
- [cupertino_icons](https://pub.dev/packages/cupertino_icons) (versión 1.0.2)
- [dio](https://pub.dev/packages/dio) (versión 5.1.2)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) (versión 8.1.2)
- [flutter_credit_card](https://pub.dev/packages/flutter_credit_card) (versión 3.0.6)
- [flutter_stripe](https://pub.dev/packages/flutter_stripe) (versión 9.2.0)
- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) (versión 10.4.0)
- [google_fonts](https://pub.dev/packages/google_fonts) (versión 5.0.0)

## Instalación

1. Clona este repositorio en tu máquina local.
2. Asegúrate de tener Flutter instalado en tu sistema.
3. Navega hasta el directorio del proyecto en tu terminal.
4. Ejecuta el siguiente comando para obtener las dependencias del proyecto:

```bash
flutter pub get
```

5. Ejecuta la aplicación con el siguiente comando:

```bash
flutter run
```

## Configuración

1. Antes de ejecutar la aplicación, asegúrate de configurar las claves de API de Stripe. Puedes encontrar más información sobre cómo obtener las claves de API en la documentación oficial de Stripe.
2. Una vez que tengas las claves de API, modifica el archivo `lib/stripe_service.dart` y reemplaza los valores de las variables `apiKey` y `publishableKey` con tus propias claves de API de Stripe.

## Contribución

Las contribuciones son bienvenidas. Si encuentras un problema o tienes una sugerencia de mejora, por favor abre un _issue_ o envía una solicitud de _pull request_.

## Licencia

Este proyecto está bajo la [Licencia MIT](LICENSE).
```
