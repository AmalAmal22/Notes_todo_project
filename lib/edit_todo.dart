import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes_todo_project/constatnts.dart';
import 'package:notes_todo_project/notes_todo.dart';

class EditTodo extends StatefulWidget {
    EditTodo({Key? key,required this.title,required this.content,required  this.id}) : super(key: key);
    String title;
    String content;
    int id;
  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController contentcontroller=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titlecontroller.text=widget.title;
    contentcontroller.text=widget.content;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT HERE'),
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: titlecontroller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text('content'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: contentcontroller,
            ),
          ),
          MaterialButton(onPressed: ()async{
            Response edit= await patch(Uri.parse('${Constants.baseurl}/edit_note'),
            body: jsonEncode({
              'title': titlecontroller.text,
              'content': contentcontroller.text,
              'id':widget.id,
            }));
             Navigator.push(context,MaterialPageRoute(builder:(context)=>NotesTodo()));
          },
            child: Text('CONFIRM'),
          )
        ]),
      ),
    );
  }
}
