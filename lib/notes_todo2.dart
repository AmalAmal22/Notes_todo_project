import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes_todo_project/constatnts.dart';
import 'package:notes_todo_project/notes_todo.dart';

class NotesTodo2 extends StatefulWidget {
  const NotesTodo2({Key? key}) : super(key: key);

  @override
  State<NotesTodo2> createState() => _NotesTodo2State();
}

class _NotesTodo2State extends State<NotesTodo2> {
  // Future<Map> getData() async {
  //   String url = 'http://192.168.29.180:8080/add_note';
  //   Response response = await get(Uri.parse(url));
  //   return jsonDecode(response.body);
  // }

  TextEditingController newcontroller = TextEditingController();
  TextEditingController oldcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Here',
            style: TextStyle(
                color: Colors.green[400], fontWeight: FontWeight.w900, fontSize: 30)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                controller: newcontroller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Content',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                controller: oldcontroller,
              ),
            ),
            MaterialButton(color: Color.fromRGBO(151, 156, 151, 1),
                onPressed: () async {
                  Response response = await post(
                      Uri.parse('${Constants.baseurl}/add_note'),
                      body: jsonEncode({
                        'title': newcontroller.text,
                        'content': oldcontroller.text
                      }));
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>NotesTodo()));
                },
                child: Text('ADD',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w900,color: Color.fromRGBO(237, 2, 26, 1)),))
          ],
        ),
      ),
    );
  }
}
