import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maghari_flutter/homepage.dart';
import 'firebase_options.dart';
import 'package:maghari_flutter/models/items.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Update(
    title: '',
  ));
}

class Update extends StatelessWidget {
  const Update({super.key, required String title});

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
      home: const Update(title: 'Flutter Demo Home Page'),
    );
  }
}

class UpdateItemPage extends StatefulWidget {
  const UpdateItemPage({Key? key, required this.itemId}) : super(key: key);
  final String itemId;

  @override
  _UpdateItemPageState createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getItemData();
    // updateItemData();
  }

  void getItemData() async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('items')
        .doc(widget.itemId)
        .get();
    final data = doc.data() as Map<String, dynamic>;
    _nameController.text = data['name'];
    _descriptionController.text = data['description'];
    _taskController.text = data['task'];
  }

  void updateItemData() async {
    final docRef =
        FirebaseFirestore.instance.collection('projects').doc(widget.itemId);
    final updatedData = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'task': _taskController.text,
      // add more fields as needed
    };
    await docRef.update(updatedData);
    print('Document updated successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Widget'),
      ),
      body: Form(
        //key: _formKey, // Global key used here
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Form(
              //key: _formKey, // ERROR: Duplicate global key used here
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
