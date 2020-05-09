import 'package:flutter/material.dart';

class TerminosCondicionesPage extends StatelessWidget {
  const TerminosCondicionesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            padding: EdgeInsets.only(top: 15),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      "Pólitica de privacidad de datos, términos y condiciones",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      '1. Identidad y domicilio del responsable',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                        'El responsable del tratamiento y protección de sus datos personales es Bubbletown S.A de C.V en adelante (Bubbletown®) con domicilio en Calle Marsella 14, Colonia Juárez, Delegación Cuauhtémoc, Ciudad de México, Código Postal 06600.'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('2. Datos Obtenidos',
                      style: TextStyle(
                        fontSize: 14,
                      ),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                        'Los datos personales que obtenemos en nuestra aplicación móvil son: \n -Nombre completo \n -Sexo \n -Fecha de nacimiento \n -Correo electrónico \n -Foto de perfil o avatar \n -Datos públicos de la red social con la que se registro en caso de realizar el registro a través de un tercero. \n'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('3. Finalidades',
                      style: TextStyle(
                        fontSize: 14,
                      ),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                        'Los datos obtenidos serán utilizados para los siguientes fines: \n -Suscribirse a nuestro programa de lealtad \n -Enviarle notificaciones, premios y promociones \n  Invitarle a participar en dinámicas y eventos de la empresa \n  Identificar las transacciones que realiza en nuestra empresa para acumular y redimir puntos y sellos en su cuenta por consumir con nosotros. \n  Informarle el historial de sus transacciones y su trayectoria en el programa de lealtad. \n  Atender de forma personalizada sus opiniones, necesidades y quejas \n  Realizar su solicitud de revocación de consentimiento y negativa a finalidades secundarias al correo programadelealtad.terminos@gmail.com y tendrá una respuesta en un plazo menor a 6 meses. \n  Finalidades secundarias \n  Comunicarle promociones y beneficios vigentes del programa de lealtad (publicidad y mercadotecnia) \n  Enviarle información sobre los productos , servicios, cupones de descuento y beneficios que ofrece nuestra marca (Publicidad y Mercadotecnia). \n  Poder identificarle para hacer entrega de premios y bonificaciones. \n  Realizar análisis y estudios de mercado. \n  Negación al tratamiento para finalidades secundarias \n  Si desea que sus datos personales no sean utilizados para todas o alguna(s) de las finalidades secundarias establecidas en el presente Aviso de Privacidad, deberá enviarnos un correo electrónico a la dirección programadelealtad.terminos@gmail.com indicándonos lo siguiente: \n  No consiento que mis datos personales se utilicen para las siguientes Finalidades Secundarias: \n  a)    Comunicarme promociones y beneficios vigentes del programa de recompensas de Bubbletown®. \n  b)    Enviarme información sobre los productos, servicios, cupones de descuento y beneficios que ofrecen nuestras marcas y socios comerciales (Publicidad y Mercadotecnia). \n  c)     Realizar concursos, trivias y sorteos mediante nuestro sitio web y en nuestras Redes Sociales (Facebook, Twitter e Instagram). \n  d)    Poder identificarte y hacerme entrega de premios en los que resulte ganador de acuerdo a nuestros concursos y sorteos. \n  e)    Realizar análisis y estudios de mercado. \n  f)      Invitación a nuestros eventos especiales y lanzamientos exclusivos de nuestras tiendas de las marcas participantes. \n  El manifestar su negativa al tratamiento de sus datos personales para finalidades secundarias, no será motivo para dejar de brindarle nuestros servicios.'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('4. Acumulación de sellos',
                      style: TextStyle(
                        fontSize: 14,
                      ),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('El realizar compras en la tienda te permitirá recibir sellos en tu tarjeta de lealtad, los cuales después de cierta cantidad podrás recibir algún producto de cortesía que la empresa decida, al acumular todos los sellos disponibles en la tarjeta que aparecerá en la aplicación se considerará como acreedor al premio correspondiente y podrá volver a llenar su tarjeta de sellos para obtener un beneficio. La recompensa que se obtendrá al acumular todos los sellos aparecerá en la parte posterior de la tarjeta. Para obtener un  sello se deberá presentar la tarjeta que aparece en la aplicación móvil para poder capturar los datos del participante al que se le otorgará el sello, que después de realizar su compra recibirá el sello en su aplicación móvil. La tarjeta de sellos tiene vigencia, por lo que la tarjeta deberá ser llenada durante el tiempo de vigencia, de lo contrario podrá cambiar el premio o podrán borrarse los sellos que llevaba acumulados, según la empresa lo considere.  Un  sello también podrá ser acumulado por alguna promoción, responder una ensta o participar en alguna dinámica de la empresa. Los sellos podrán tardar hasta 24 horas en verse reflejados en la aplicación.'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('5. Sistema de puntos',
                      style: TextStyle(
                        fontSize: 14,
                      ),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('Al realizar compras podrás obtener una bonificación en puntos (en lo sucesivo , los “bublins”) que podrás canjear por productos de la empresa. Los puntos no tienen valor monetario y no pueden canjearse por dinero en efectivo o algún título de crédito'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('6. Generalidades',
                      style: TextStyle(
                        fontSize: 14,
                      ),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('Bubbletown se reserva el derecho de cancelar tu cuenta y/o participación en el programa de lealtad si así el personal de la empresa o el sistema considera que has violado los términos de uso, o que el uso de tu cuenta no es autorizado, es fraudulento o ilegal. La empresa se reserva el derecho de hacer inválida cualquier bonificación o premio que algún participante intente realizar si este se considera sospechoso, de igual forma se reserva el derecho de dar de baja cualquier cuenta del programa de lealtad. La empresa se reserva el derecho de terminar, descontinuar o cancelar el programa de lealtad en cualquier momento sin necesidad de alguna notificación previa. La empresa se deslinda de cualquier uso inapropiado de la aplicación dejando la responsabilidad al titular de la aplicación.  Al registrarte y hacer uso del programa, aceptas los presentes términos y condiciones descritos, y los términos relacionados a los que se haga referencia, asimismo, confirmas haber leído el Aviso de Privacidad del programa y aceptado el mismo. En caso de no aceptar la totalidad de los presentes términos y condiciones, deberás reservarte el derecho de participar en el programa. La participación continua en este programa de lealtad confirmará tu aceptación de los cambios o modificaciones realizadas al programa y sus términos. Es responsabilidad de los miembros del programa revisar las actualizaciones y/o modificaciones de los presentes Términos y Condiciones aplicables a el programa de lealtad frecuentemente. Es obligación de los miembros del programa leer el Aviso de Privacidad cuidadosamente para entender cómo BubbleTown recolecta, utiliza y muestra la información de sus participantes.'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
