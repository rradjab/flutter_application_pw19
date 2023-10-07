import 'package:flutter/material.dart';

import 'src/messages.g.dart';

void main() {
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pigeon Example'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  final _hostApi = MessageApi();
  Message _hostApiResult = Message();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_hostApiResult.length != null)
              Card(
                child: ListTile(
                  title: Text(_hostApiResult.inLowerCase!),
                  subtitle: Text(_hostApiResult.inUpperCase!),
                  trailing: Text('Legnth - ${_hostApiResult.length}'),
                ),
              ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Type text and Submit to interact with native'),
              onSubmitted: (value) async {
                _hostApiResult = await _hostApi.getMessage(value);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
