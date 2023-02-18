import 'package:flutter/material.dart';
import 'package:maghari_flutter/homepage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it

        child: Container(
            height: MediaQuery.of(context).size.height,
            //height: MediaQuery.of(context).orientation.portrait,
            width: MediaQuery.of(context).size.width,
            // Column is also a layout widget. It takes a list of children and

            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/logo.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                  top: 50,
                )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Ateneo De Davao University',
                        style: TextStyle(
                            height: 0.4,
                            fontSize: 40,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ]),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Community Center',
                      style: TextStyle(
                          height: 0.4,
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      'Asset Management System',
                      style: TextStyle(
                          height: 0.4,
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 80)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    NeumorphicButton(
                        margin: EdgeInsets.only(top: 12),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new MyApp2()));
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Login with Google",
                          style: TextStyle(color: Colors.blue),
                        )),
                    NeumorphicButton(
                        margin: EdgeInsets.only(top: 12),
                        onPressed: () {
                          // NeumorphicTheme.of(context).themeMode =
                          //     NeumorphicTheme.isUsingDark(context)
                          //         ? ThemeMode.light
                          //         : ThemeMode.dark;
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Login with as Guest",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                )
              ],
            )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
