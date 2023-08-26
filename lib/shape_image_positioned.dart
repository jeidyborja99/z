import 'package:flutter/material.dart'; // Cambio en la importación

class ShapeImagePositioned extends StatelessWidget {
  const ShapeImagePositioned({Key? key, this.top = -50}) : super(key: key);
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 450,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/shape.png'), // Cambia la ruta de la imagen según tu proyecto
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
