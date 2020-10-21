import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  static const platform = const MethodChannel('samples.flutter.dev/channel');

  String textHolder = 'No data received yet!';

  Future<void> _onDataFetchedFromNative() async {
    String receivedText;
    try {
      final String result = await platform.invokeMethod('getDataFromNative');
      receivedText = result;
    } on PlatformException catch(exception) {
      receivedText = "Failed to get text: '${exception.message}'";
    }
    setState(() {
      textHolder = receivedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Platform Channel Demo'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text('Get Data from Native'),
                onPressed: () {
                  _onDataFetchedFromNative();
                },
              ),
              Text('$textHolder',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ] ,
          ),
        ),
      ),
    );
  }
}
