import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/semantics.dart';
import 'package:myapp/src/PostPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InitApp());
}

//initialize App setting
class InitApp extends StatefulWidget {
  _InitFirebase createState() => _InitFirebase();
}

class _InitFirebase extends State<InitApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print("SomethingWentWrong");
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print("Loading");
    }
    return MyApp();
  }
}

// startApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAuthPage(),
    );
  }
}

class MyAuthPage extends StatefulWidget {
  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  // Email
  String email = "";
  // password
  String password = "";
  // information
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Email
              TextFormField(
                decoration: InputDecoration(labelText: "?????????????????????"),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              // Password
              TextFormField(
                decoration: InputDecoration(labelText: "???????????????(6????????????)"),
                // ?????????????????????????????????????????????
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                // ?????????????????????
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                // ???????????????????????????
                child: ElevatedButton(
                  child: Text('??????????????????'),
                  onPressed: () async {
                    try {
                      // make user with mail&password
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // ???????????????????????????????????????
                      // ?????????????????????????????????????????????????????????
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return PostPage(result.user!);
                        }),
                      );
                    } catch (e) {
                      // ???????????????????????????
                      setState(() {
                        infoText = "??????NG:${e.toString()}";
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                // ???????????????????????????
                child: OutlineButton(
                  child: Text('????????????'),
                  onPressed: () async {
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      final result = await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // login success
                      // ?????????????????????????????????????????????????????????
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return PostPage(result.user!);
                        }),
                      );
                    } catch (e) {
                      // login ??????
                      setState(() {
                        infoText = "?????????????????????????????????:${e.toString()}";
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
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
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
