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
import 'package:maghari_flutter/create.dart';
import 'package:maghari_flutter/update.dart';
import 'package:maghari_flutter/project.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Item {
  String name;
  String description;
  String task;
  String task2;
  String task3;
  String task4;
  String task5;
  String id;

  Item(
      {required this.name,
      required this.description,
      required this.task,
      required this.task2,
      required this.task3,
      required this.task4,
      required this.task5,
      required this.id});
}

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
      FirebaseFirestore.instance.collection('users').snapshots();

  List<Item> _items = [];

  late String userId;
  late String projectId;

  @override
  void initState() {
    super.initState();
    // Get the current user
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is signed in
      userId = user.uid;

      // Access Firestore collection using the user's UID
      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("projects")
          .get()
          .then(
        (querySnapshot) {
          List<Item> all_items = [];
          // Process query results
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            String id = docSnapshot.id;
            String name = docSnapshot.get('name');
            String description = docSnapshot.get('description');
            String task = docSnapshot.get('task');
            String task2 = docSnapshot.get('task2');
            String task3 = docSnapshot.get('task3');
            String task4 = docSnapshot.get('task4');
            String task5 = docSnapshot.get('task5');
            Item item = Item(
              name: name,
              description: description,
              task: task,
              task2: task2,
              task3: task3,
              task4: task4,
              task5: task5,
              id: id,
            );
            all_items.add(item);
          }
          setState(() {
            _items = all_items;
          });
        },
        onError: (e) => print("Error completing: $e"),
      ).catchError((e) => print("Error occurred: $e"));
    } else {
      // No user signed in
      print("User is not signed in");
    }
  }

  void deleteProject(String projectId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('projects')
        .doc(projectId)
        .delete()
        .then((value) {
      print('Project deleted successfully');
      setState(() {
        _items.removeWhere((item) => item.id == projectId);
      });
    }).catchError((error) => print('Failed to delete project: $error'));
  }

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 30,
          ),
          height: 120,
          child: NeumorphicButton(
            onPressed: () {
              // add your button's on press action here
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => new Create()));
            },
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text('Create New Project',
                      style: TextStyle(
                        height: 1,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 20)),
        Text(
          'Recent Projects',
          textAlign: TextAlign.left,
          style: TextStyle(
            height: 1,
            fontSize: 30,
            fontFamily: 'Nunito-Bold',
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(69, 0, 0, 0),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 20)),
        Expanded(
          child: Container(
            child: GridView.builder(
              itemCount: _items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                Item item = _items[index];

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
                        // Image.network(
                        //   item.img,
                        //   width: 800,
                        //   height: 200,
                        // ),
                        Padding(padding: const EdgeInsets.all(10)),
                        Text(
                          item.name,
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
                              item.description,
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
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            child: Text(
                              item.task,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 15,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            child: Text(
                              item.task2,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 15,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            child: Text(
                              item.task3,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 15,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            child: Text(
                              item.task4,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 15,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            child: Text(
                              item.task5,
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
                        Container(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .end, // Align the column at the bottom
                            children: [
                              Expanded(
                                // Use an Expanded widget to fill the remaining vertical space
                                child: NeumorphicButton(
                                  margin: EdgeInsets.only(top: 5),
                                  onPressed: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new project()));
                                  },
                                  child: Center(
                                    child: Text('See Project'),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: NeumorphicButton(
                                    margin: EdgeInsets.only(top: 5),
                                    onPressed: () async {
                                      deleteProject(item.id);
                                    },
                                    child: Center(
                                      child: Text('Delete Project'),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: NeumorphicButton(
                                    margin: EdgeInsets.only(top: 5),
                                    onPressed: () async {
                                      //deleteProject(item.id);
                                    },
                                    child: Center(
                                      child: Text('Comment'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
