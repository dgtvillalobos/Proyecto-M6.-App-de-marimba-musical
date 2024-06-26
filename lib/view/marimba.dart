import 'package:flutter/material.dart';
import 'package:proyecto6/model/xilofono.dart';
import 'package:audioplayers/audioplayers.dart';

class Marimba extends StatefulWidget {
  const Marimba({Key? key}) : super(key: key);

  @override
  State<Marimba> createState() => _MarimbaState();
}

class _MarimbaState extends State<Marimba> {
  late List<bool> _isPressedList;
  late AudioPlayer _audioPlayer;

  List<Xilofono> listaDatos = [
    Xilofono(
      'sonido/marimba1.mp3',
      'assets/imagen/Recurso 2.png',
    ),
    Xilofono(
      'sonido/marimba2.mp3',
      'assets/imagen/Recurso 3.png',
    ),
    Xilofono(
      'sonido/marimba3.mp3',
      'assets/imagen/Recurso 4.png',
    ),
    Xilofono(
      'sonido/marimba4.mp3',
      'assets/imagen/Recurso 5.png',
    ),
    Xilofono(
      'sonido/marimba5.mp3',
      'assets/imagen/Recurso 10.png',
    ),
    Xilofono(
      'sonido/marimba6.mp3',
      'assets/imagen/Recurso 7.png',
    ),
    Xilofono(
      'sonido/marimba7.mp3',
      'assets/imagen/Recurso 8.png',
    ),
    Xilofono(
      'sonido/marimba8.mp3',
      'assets/imagen/Recurso 9.png',
    )
  ];

  @override
  void initState() {
    super.initState();
    _isPressedList = List.generate(listaDatos.length, (index) => false);
    _audioPlayer = AudioPlayer();
  }

  void tocarSonido(String audioUrl) async {
    _audioPlayer.setSourceAsset(audioUrl);

    await _audioPlayer.resume();
  }

  void detenerSonido() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error al detenerse');
    }
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
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(listaDatos.length, (index) {
                return GestureDetector(
                  onTapDown: (_) async {
                    setState(() {
                      _isPressedList[index] = true;
                    });
                    tocarSonido(listaDatos[index].rutaSonido);
                  },
                  onTapUp: (_) {
                    setState(() {
                      _isPressedList[index] = false;
                    });

                    // detenerSonido();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    width: _isPressedList[index]
                        ? MediaQuery.of(context).size.width - 100
                        : MediaQuery.of(context).size.width - 90,
                    child: Image.asset(
                      listaDatos[index].rutaImagen,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
