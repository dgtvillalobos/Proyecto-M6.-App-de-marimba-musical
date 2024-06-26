import 'package:flutter/material.dart';
import 'package:proyecto6/view/marimba.dart';
import 'dart:math';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animacion Logo',
      routes: {
        '/marimba': (context) => const Marimba(),
      },
      home: InicioApp(),
    );
  }
}

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InicioAppViewState createState() => _InicioAppViewState();
}

class _InicioAppViewState extends State<InicioApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _scaleAnimation = Tween<double>(begin: 1, end: 4).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInSine));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/marimba');
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imagen/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Image.asset(
                    'assets/imagen/Recurso 1.png',
                    width: 70,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
