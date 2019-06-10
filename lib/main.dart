import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutterdemo/utils/shared_preference.dart';
import 'package:flutterdemo/resources/shared_preferences_keys.dart';
import 'package:flutterdemo/views/welcome_page/index.dart';
import 'package:flutterdemo/views/first_page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  SpUtil sp;

  MyApp() {
    final router = new Router();
  }

  showWelcomePage() {
    bool showWelcome = sp.getBool(SharedPreferencesKeys.showWelcome);
    if (showWelcome == null || showWelcome == true) {
      return WelcomePage();
    } else {
      return AppPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
