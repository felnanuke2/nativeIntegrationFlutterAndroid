import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counte = 0;

  MethodChannel _methodChannel = MethodChannel(
    'floating_button',
  );

  bool _created = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodChannel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'increment':
          setState(() {
            _counte += 1;
          });

          break;
        default:
      }
      return Future.value(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$_counte',
              style: TextStyle(fontSize: 26),
            ),
            ListTile(
              tileColor: Colors.blue,
              onTap: _createMethoedChannel,
              title: Text('Create'),
            ),
            ListTile(
              onTap: _hideFloatingButton,
              tileColor: Colors.green,
              title: Text('Hide'),
            ),
            ListTile(
              onTap: _showFloatingButton,
              tileColor: Colors.amber,
              title: Text('Show'),
            ),
          ],
        ),
      ),
    );
  }

  _createMethoedChannel() {
    if (_created) return;
    _methodChannel.invokeMethod('create');
    _created = true;
  }

  _showFloatingButton() {
    _methodChannel.invokeMethod('show');
  }

  _hideFloatingButton() {
    _methodChannel.invokeMethod('hide');
  }

  _destoryFloatingButton() {
    _methodChannel.invokeMethod('destroy');
  }
}
