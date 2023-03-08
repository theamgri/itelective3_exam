import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
////import 'package:provider/provider.dart';
//import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
//import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter/material.dart';
import 'package:maghari_flutter/models/items.dart';
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
      body: LeftDrawer(),
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
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _itemStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Item item = Item(
                  id: document.id,
                  name: data['name'],
                  description: data['description'],
                  img: data['img'],
                );
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['description']),
                  // leading: Image.asset(
                  //   "data['img']",
                  //   width: 50,
                  //   height: 50,
                  // ),
                );
              }).toList(),
            );
          }),
    );
  }
}
