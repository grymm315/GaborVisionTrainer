import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gabor Stimulus Trainer',
      color: Colors.grey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Click on the stimulus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _opacity = 1.0;
  Offset _position = const Offset(0, 0);
  final Random _random = Random();

  void _moveButton() async {

    setState(() {
      _opacity = 0.0;
      _counter++;
    });

    // Wait for fade out to complete
    await Future.delayed(const Duration(milliseconds: 1));

    // Calculate new random position
    final double newX = _random.nextDouble() * 300 - 150; // Range: -150 to 150
    final double newY = _random.nextDouble() * 300 - 150; // Range: -150 to 150

    // Update position and start fade in
    setState(() {
      _position = Offset(newX, newY);
      _opacity = 1.0;
    });
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Colors.black12,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Transform.translate(offset: _position, child:
              AnimatedOpacity(opacity: (_opacity),
                duration: const Duration(milliseconds: 4500),
                child: MouseRegion( // Add MouseRegion for better cursor handling
                    cursor: SystemMouseCursors.click,
                    child: Container( // Add Container to maintain consistent hit test area
                      width: 100,
                      height: 100,
                      color: Colors.transparent,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                    onTap: _moveButton,
                    child: Image.asset('assets/gabor.png',
                  width: 100,
                  height: 100,
                      fit: BoxFit.contain,
                ))
            ,)
          ,)
      ,)
            ,),
              Text(
                '$_counter',
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
              )
            ],
          ),
        ),


        floatingActionButton: FloatingActionButton(
          onPressed: _moveButton,
          tooltip: 'Increment',
          child: const Icon(Icons.error),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }

