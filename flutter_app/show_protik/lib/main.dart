import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Student> studentData = [];
  bool isProcessing = false;
  bool isSuccessfull = false;
  final String url = "http://localhost:3000/student";

  Future<void> getInfo() async {
    isProcessing = true;
    try {
      final respone = await http.get(Uri.parse(url));
      print(respone.statusCode);
      print(respone.body);
      if (respone.statusCode == 200) {
        dynamic responseBody = jsonDecode(respone.body);

        Student student = Student.fromJson(responseBody);
        studentData.add(student);
        setState(() {});
        isSuccessfull = true;
        isProcessing = false;
      } else {
        isSuccessfull = false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            studentData.isNotEmpty
                ? Text(studentData[0].name ?? "sorry")
                : Text("no data"),
            Text("helo"),
            ElevatedButton(onPressed: getInfo, child: Text("Get Info")),
          ],
        ),
      ),
    );
  }
}

class Student {
  String? name;
  int? age;
  double? cgpa;
  String? dept;

  Student({this.name, this.age, this.cgpa, this.dept});

  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    cgpa = json['cgpa'];
    dept = json['dept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['cgpa'] = this.cgpa;
    data['dept'] = this.dept;
    return data;
  }
}
