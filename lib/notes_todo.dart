import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes_todo_project/constatnts.dart';
import 'package:notes_todo_project/edit_todo.dart';

import 'notes_todo2.dart';

class NotesTodo extends StatefulWidget {
  NotesTodo({Key? key}) : super(key: key);

  @override
  State<NotesTodo> createState() => _NotesTodoState();
}

class _NotesTodoState extends State<NotesTodo> {
  Future<List> getData() async {
    String url = '${Constants.baseurl}/get_notes';
    Response notes = await get(Uri.parse(url));
    return jsonDecode(notes.body)['message'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text(
        'Notes',
        style: TextStyle(fontSize: 37, color: Colors.brown),
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: Card(
                              elevation: 10,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(164, 186, 178, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Row(
                                        children: [
                                          Text(
                                            snapshot.data![index]['title'],
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(child: SizedBox()),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return EditTodo(
                                                    id: snapshot.data![index]
                                                        ['id'],
                                                    title: snapshot.data![index]
                                                        ['title'],
                                                    content:
                                                        snapshot.data![index]
                                                            ['content'],
                                                  );
                                                }));
                                              },
                                              icon: Icon(Icons.delete)),
                                          IconButton(
                                              onPressed: () async {
                                                Response res = await delete(
                                                    Uri.parse(
                                                        '${Constants.baseurl}/remove_note'),
                                                    body: jsonEncode({
                                                      'id': snapshot
                                                          .data![index]['id']
                                                    }));
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.delete)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(snapshot.data![index]['content'])
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: Text('NO Data'),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotesTodo2(),
                          ));
                    },
                    child: Text(
                      'Create a Note',
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
