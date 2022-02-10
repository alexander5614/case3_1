import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class SharedPref extends StatelessWidget {
  const SharedPref({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(storage: CounterStorage(), title: null,),);
  }

}


class CounterStorage {
  Future<String> get _localPath async{
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
Future<File> get _localFile async {
  final path = await _localPath;
  return File("$path/counter.txt");
}
Future<int> readCounter() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return int.parse(contents);
          }
          catch(e) {
      return 0;
          }
}  
Future<File> writeCounter(int counter2) async {
    final file = await _localFile;
    return file.writeAsString("$counter2");
}
}

class Int {
}


class MyHomePage extends StatefulWidget {
  var title;

  MyHomePage({Key? key, required this.storage, required this.title}) : super(key: key);

  final CounterStorage storage;



  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _counter2 = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) => (int value) {
      setState(() {
        _counter2 = value;
      });});
     _localcounter();
  }
  Future<File> _incrementcounter2() {
    setState(() {
      _counter2 ++;
    });
    return widget.storage.writeCounter(_counter2);
  }


  void _localcounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt("counter") ?? 0);
    });
  }
void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt("counter") ?? 0) + 1;
      prefs.setInt("counter", _counter);
    });
}

@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Счетчик Кузнецова"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 180, height: 60 , child: ElevatedButton(
              onPressed:_incrementCounter,
              child: const Text("Кликни здесь"),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(0, 121, 208, 1),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(36.0),),
              ),),),

            const Text("Столько раз вы нажали кнопку КЛИКНИ:",style: TextStyle(fontSize: 20),),
            Text("$_counter", style: const TextStyle(fontSize: 36),),
            SizedBox(width: 180, height: 60 , child: ElevatedButton(
              onPressed:_incrementcounter2,
              child: const Text("Тапни здесь"),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(0, 121, 208, 1),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(36.0),),
              ),),),

            const Text("Столько раз вы нажали кнопку ТАПНИ:", style: TextStyle(fontSize: 20),),
            Text("$_counter2", style: const TextStyle(fontSize: 36),),
          ],
        ),
      ),

    );
}
}


