import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maghari_flutter/homepage.dart';
import 'firebase_options.dart';
import 'package:maghari_flutter/homepage.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Create());
}

class Create extends StatelessWidget {
  const Create({super.key});

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
          //primarySwatch: Color.fromARGB(255, 232, 232, 232),
          ),
      home: const Create2(title: 'Flutter Demo Home Page'),
    );
  }
}

class Create2 extends StatefulWidget {
  const Create2({super.key, required this.title});
  final String title;

  @override
  State<Create2> createState() => _CreatePageState();
}

class _CreatePageState extends State<Create2> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = '';
  String _projectDescription = '';
  String _projectTask = '';
  String _projectTask2 = '';
  String _projectTask3 = '';
  String _projectTask4 = '';
  String _projectTask5 = '';

  void _createNewProject() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    // Get the current user's ID
    String userId = auth.currentUser!.uid;

    // Get a reference to the user's document and create a new 'projects' collection
    DocumentReference userDocRef = firestore.collection('users').doc(userId);
    CollectionReference projectsCollection = userDocRef.collection('projects');

    // Add the new project to the 'projects' collection with the name, description, and task fields
    await projectsCollection.add({
      'name': _projectName,
      'description': _projectDescription,
      'task': _projectTask,
      'task2': _projectTask2,
      'task3': _projectTask3,
      'task4': _projectTask4,
      'task5': _projectTask5,
    });

    // Print a success message
    print('Project added successfully!');
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              //title: Text('Create new project?'),
              content: Text('Are you sure you want to create a new project?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Create'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Create New Project'),
      // ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Create Projects',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    height: 1,
                    fontSize: 30,
                    fontFamily: 'Nunito-Bold',
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(69, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Project Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a project name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _projectName = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Project Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a project description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _projectDescription = value!;
                  },
                  maxLines: 5,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Task 1',
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.check_box),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _projectTask = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Task 2',
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.check_box),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _projectTask2 = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Task 3',
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.check_box),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _projectTask3 = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Task 4',
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.check_box),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _projectTask4 = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Task 5',
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.check_box),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _projectTask5 = value!;
                  },
                ),
                SizedBox(height: 16),
                Container(
                    child: NeumorphicButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      bool confirm = await _showConfirmationDialog(context);
                      if (confirm) {
                        _createNewProject();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('New project created successfully!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Create Project'),
                )),
                Padding(padding: EdgeInsets.only(top: 20)),
                NeumorphicButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new MyApp2()));
                  },
                  child: Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
