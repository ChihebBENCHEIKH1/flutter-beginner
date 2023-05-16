import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../models/db_model.dart';
import '../models/todo_model.dart';
import './todo_card.dart';

class Todolist extends StatelessWidget {
  // create an object of database connect
  // to pass down to todocard, first our todolist have to receive the functions
  final Function insertFunction;
  final Function editFunction;
  final Function deleteFunction;
  final db = FirebaseDatabase.instance.reference().child('tasks');
  Todolist(
      {required this.insertFunction, required this.deleteFunction, Key? key,
      required this.editFunction,String?keyItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
        query: db,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          final  data = snapshot.value as Map;
          String key=snapshot.key.toString();
          print(data['date']+"\n");
          return Todocard(
            id: key,
            title: data['title'],
            creationDate: data['date'],
            isChecked: true,
            insertFunction: insertFunction,
            deleteFunction: deleteFunction,
            editFunction:editFunction
          );
        },
      ),
    );
  }
}
