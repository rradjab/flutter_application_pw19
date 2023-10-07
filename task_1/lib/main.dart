import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_pw19/platform/platform_service.dart';
import 'package:flutter_application_pw19/platform/platform_view_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final service = getServie();
  TextEditingController controller = TextEditingController();
  String text = 'initial button value';
  int length = 0;

  final _controllerStream = StreamController();

  @override
  void initState() {
    _controllerStream.addStream(service.getTextLength());
    _controllerStream.stream.listen((event) {
      length = event;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('MultiPlatform App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Press platform button to get text length',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Container(
                color: Colors.amber,
                height: 50,
                width: MediaQuery.of(context).size.width / 2,
                child: PlatformWidget(text: text),
              ),
              const Divider(),
              Text(
                'Platform button text length = $length',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextField(
                  decoration: const InputDecoration(
                      labelText: 'Type platform button text'),
                  controller: controller,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (controller.text.isNotEmpty) {
                      service.setText(controller.text);
                      setState(() {});
                      controller.text = '';
                      length = controller.text.length;
                    }
                  },
                  child: const Text('Set platform button text'))
            ],
          ),
        ),
      ),
    );
  }
}
