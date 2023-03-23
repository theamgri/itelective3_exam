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
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const project());
}

class project extends StatelessWidget {
  const project({super.key});

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
      home: const MyProject2(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyProject2 extends StatefulWidget {
  const MyProject2({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyProject2> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject2> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _itemStream =
      FirebaseFirestore.instance.collection('items').snapshots();

  List<Item> _items = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();

  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('users');

  late String projectId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('projects')
        .doc(projectId)
        .get()
        .then((doc) {
      if (doc.exists) {
        final data = doc.data();
        _nameController.text = data?['name'] ?? '';
        _descriptionController.text = data?['description'] ?? '';
        _taskController.text = data?['task'] ?? '';
        // add more fields as needed
      } else {
        print('Item not found');
      }
    }).catchError((error) => print('Failed to fetch item data: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('projects').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!.docs;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item['name']),
                subtitle: Text(item['description']),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateItemForm(
                          projectId: item.id,
                          name: item['name'],
                          description: item['description'],
                          task: item['task'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('projects')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!.docs;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item['name']),
                subtitle: Text(item['description']),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateItemForm(
                          projectId: item.id,
                          name: item['name'],
                          description: item['description'],
                          task: item['task'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class UpdateItemForm extends StatefulWidget {
  final String projectId;
  final String name;
  final String description;
  final String task;

  UpdateItemForm(
      {required this.projectId,
      required this.name,
      required this.description,
      required this.task});

  @override
  _UpdateItemFormState createState() => _UpdateItemFormState();
}

class _UpdateItemFormState extends State<UpdateItemForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _taskController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  //late String postId;
  @override
  void initState() {
    _nameController.text = widget.name;
    _descriptionController.text = widget.description;
    _taskController.text = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
          ),
        ),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
          ),
        ),
        TextFormField(
          controller: _taskController,
          decoration: InputDecoration(
            labelText: 'Task',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedData = {
              'name': _nameController.text,
              'description': _descriptionController.text,
              'task': _taskController.text,
            };
            // updateItem(widget.projectId, updatedData);
          },
          child: Text('Update Item'),
        ),
      ],
    );
  }

  // void updateItem(String projectId, Map<String, dynamic> updatedData) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   final docRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .collection('projects')
  //       .doc(projectId);
  //   await docRef.update(updatedData);
  //   print('Item updated successfully');
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _taskController.dispose();
    super.dispose();
  }
}
