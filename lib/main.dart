import 'package:flutter/material.dart';
import 'package:reverse_platform_methods/string_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final stringService = StringService();
  runApp(MyApp(stringService));
}

class MyApp extends StatefulWidget {
  final StringService _stringService;

  MyApp(this._stringService, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MyApp> {
  var string = "NOT SET";

  @override
  void initState() {
    super.initState();
    widget._stringService.stringStream.listen((newString) {
      setState(() {
        string = newString;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("String from Platform:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text(string)
            ],
          ),
        ),
      ),
    );
  }
}
