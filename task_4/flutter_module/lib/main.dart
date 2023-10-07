import 'package:flutter/material.dart';
import 'package:task_4/services/platform_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Module Example'),
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
  final platformService = PlatformService();
  int platformValue = -1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(platformValue.toString()),
          ElevatedButton(
            onPressed: () async {
              platformValue = await platformService.getValue();
              setState(() {});
            },
            child: const Text('Get value from platform'),
          ),
        ],
      ),
    );
  }
}
