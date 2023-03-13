import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter/material.dart';
import 'package:maghari_flutter/models/items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maghari_flutter/firebase_options.dart';
import 'package:maghari_flutter/main.dart';
import 'package:maghari_flutter/navbar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomePage',
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
      home: const MyHomePage2(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: LeftDrawer(),
    )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class ForData extends StatefulWidget {
  const ForData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForDataState();
}

class _ForDataState extends State<ForData> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _itemStream =
      FirebaseFirestore.instance.collection('items').snapshots();

  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    List<Item> all_items = [];
    db.collection("items").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          Item item = Item(
            id: docSnapshot.id,
            name: docSnapshot.data()['name'],
            description: docSnapshot.data()['description'],
            img: docSnapshot.data()['img'],
          );
          all_items.add(item);
          print(docSnapshot.id);
          print(docSnapshot.data()['name']);
          print(docSnapshot.data()['description']);
        }
        setState(() {
          _items = all_items;
        });
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _itemStream,
          //stream: FirebaseAuth.instance.authStateChanges();

          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ResponsiveGridList(
              minItemWidth: 800,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Item item = Item(
                  id: document.id,
                  name: data['name'],
                  description: data['description'],
                  img: data['img'],
                );
                return GridTile(
                  child: Container(
                    width: 500,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 20,
                          offset: Offset(5, 10),
                          spreadRadius: 0.1,
                          blurStyle: BlurStyle.inner,
                        ),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey.shade50, Colors.grey.shade200]),
                      border:
                          Border.all(color: Color.fromARGB(255, 132, 132, 132)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.only(top: 10)),
                        Image.network(
                          data['img'],
                          width: 800,
                          height: 200,
                        ),
                        Padding(padding: const EdgeInsets.all(10)),
                        Text(
                          data['name'],
                          style: TextStyle(
                            height: 1,
                            fontSize: 18,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            child: Text(
                              data['description'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 15,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            )),
                        Padding(padding: EdgeInsets.only(top: 10)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
