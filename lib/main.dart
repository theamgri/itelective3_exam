import 'package:flutter/material.dart';
import 'package:maghari_flutter/google_sign_in.dart';
import 'package:maghari_flutter/homepage.dart';
import 'package:maghari_flutter/signup.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_services.dart';
import 'firebase_options.dart';

//com.example.maghari_flutter
//1A:D2:28:0E:94:07:F9:8B:37:0B:0D:69:3C:D6:12:3E:03:65:20:60

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    create:
    (context) => GoogleSignInProvider();
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
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();

    super.dispose();
  }

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
    Color color = Color(0xfff0f0f0);
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
        body: StreamBuilder<User?>(
            // future: Provider.of(context, listen: false).auth.getCurrentUid(),
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  //child: Text('Logged in as ${snapshot.data!.email}'),
                  child: MyApp2(),
                );
              } else {
                return Center(
                    // Center is a layout widget. It takes a single child and positions it
                    child: Container(
                        height: 500,
                        width: 650,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 20, // shadow radius
                                offset: Offset(5, 10), // shadow offset
                                spreadRadius:
                                    0.1, // The amount the box should be inflated prior to applying the blur
                                blurStyle: BlurStyle.inner // set blur style
                                ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey.shade50,
                                Colors.grey.shade200
                              ]),
                          border: Border.all(
                              color: Color.fromARGB(255, 132, 132, 132)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 250,
                                  height: 30,
                                  child: TextField(
                                    controller: _emailController,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15.0,
                                        height: 0.5,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    textAlign: TextAlign.center,
                                    scrollPadding: EdgeInsets.all(0.0),
                                    autofocus: true,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Container(
                                  width: 250,
                                  height: 30,
                                  child: TextField(
                                    controller: _passController,
                                    obscureText: true,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15.0,
                                        height: 0.5,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    textAlign: TextAlign.center,
                                    scrollPadding: EdgeInsets.all(0.0),
                                    autofocus: true,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 200,
                                  child: NeumorphicButton(
                                    margin: EdgeInsets.only(top: 5),
                                    onPressed: () async {
                                      try {
                                        UserCredential userCredential =
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                          email: _emailController.text.trim(),
                                          password: _passController.text.trim(),
                                        );

                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text('Login successful'),
                                            content: Text(
                                                'Logged in as ${userCredential.user!.email}!'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found' ||
                                            e.code == 'wrong-password') {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: Text('Login failed'),
                                              content: Text(
                                                  'Invalid email or password'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    style: NeumorphicStyle(
                                      color: Colors.grey.shade50,
                                      shadowDarkColor:
                                          Color.fromARGB(176, 110, 110, 110),
                                      shadowLightColor:
                                          Color.fromARGB(239, 207, 207, 207),
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Login",
                                      style: TextStyle(
                                        height: 0.8,
                                        fontSize: 15,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(111, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 3)),
                                // Container(
                                //   width: 200,
                                //   child: NeumorphicButton(
                                //       margin: EdgeInsets.only(top: 5),
                                //       onPressed: () async {
                                //         // await FirebaseServices()
                                //         //     .SignInWithGoogle();
                                //         //future: Provider.of<CLASSNAME>(context, listen: false).auth.getCurrentUid();
                                //         final provider =
                                //             Provider.of(context, listen: false);
                                //         Provider.of<GoogleSignInProvider>(
                                //             context,
                                //             listen: false);
                                //         provider.googleLogin();
                                //         Navigator.pushReplacement(
                                //             context,
                                //             new MaterialPageRoute(
                                //                 builder: (context) =>
                                //                     new MyApp2()));
                                //       },
                                //       style: NeumorphicStyle(
                                //         color: Colors.grey
                                //             .shade50, // set the color to green
                                //         shadowDarkColor: Color.fromARGB(
                                //             176,
                                //             110,
                                //             110,
                                //             110), // set the shadow color to green shade 700
                                //         shadowLightColor:
                                //             Color.fromARGB(239, 207, 207, 207),
                                //         shape: NeumorphicShape.flat,
                                //         boxShape: NeumorphicBoxShape.roundRect(
                                //             BorderRadius.circular(10)),
                                //       ),
                                //       padding: const EdgeInsets.all(10.0),
                                //       child: Text(
                                //         textAlign: TextAlign.center,
                                //         "Login with Google",
                                //         style: TextStyle(
                                //             height: 0.8,
                                //             fontSize: 15,
                                //             fontFamily: 'Nunito',
                                //             fontWeight: FontWeight.w600,
                                //             color:
                                //                 Color.fromARGB(111, 0, 0, 0)),
                                //       )),
                                // ),
                                // Padding(padding: EdgeInsets.only(top: 3)),
                                Container(
                                    width: 200,
                                    child: NeumorphicButton(
                                        margin: EdgeInsets.only(top: 5),
                                        onPressed: () {
                                          // FirebaseAuth.instance
                                          //     .createUserWithEmailAndPassword(
                                          //         email: _emailController.text
                                          //             .trim(),
                                          //         password: _passController.text
                                          //             .trim());
                                          Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      new SignUp()));
                                          // NeumorphicTheme.of(context).themeMode =
                                          //     NeumorphicTheme.isUsingDark(context)
                                          //         ? ThemeMode.light
                                          //         : ThemeMode.dark;
                                        },
                                        style: NeumorphicStyle(
                                          color: Colors.grey
                                              .shade50, // set the color to green
                                          shadowDarkColor: Color.fromARGB(
                                              176,
                                              110,
                                              110,
                                              110), // set the shadow color to green shade 700
                                          shadowLightColor: Color.fromARGB(
                                              239, 207, 207, 207),
                                          shape: NeumorphicShape.flat,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Sign Up",
                                          style: TextStyle(
                                              height: 0.8,
                                              fontSize: 15,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromARGB(117, 0, 0, 0)),
                                        ))),
                                Padding(padding: EdgeInsets.only(top: 5)),
                              ],
                            )
                          ],
                        )));
              }
            }));
  }
}
