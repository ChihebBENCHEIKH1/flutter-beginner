import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/db_model.dart';
import '../models/todo_model.dart';
import '../widgets/user_input.dart';
import '../widgets/todo_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // we have to create our functions here, where the two widgets can communicate
  // function to add todo
  String key="";
  bool isClicked=false;
  void addItem(Todo todo) async {
    print(todo.creationDate);

    final DatabaseReference database1 =
    FirebaseDatabase.instance.reference();
    final newTaskRef = database1.child('tasks').push(); // get a reference to the new child location
    await newTaskRef.set({
      'title': todo.title,
      'date': todo.creationDate.toString(),
      'status': todo.isChecked,
    });
  }
  Future<void> update (Todo todo)
  async {
    final DatabaseReference database1 =
    FirebaseDatabase.instance.reference();
    String key=todo.id as String;
    final taskRef = database1.child('tasks').child(key); // Get a reference to the existing task
    await taskRef.update({
      'title': todo.title,
      'date': todo.creationDate.toString(),
      'status': todo.isChecked,
    });
    isClicked=false;

  }
  String editFunction(String key)
  {
    this.key=key;
    this.isClicked=true;
    print("key => "+key);
    return this.key;
  }
  String getKey()
  {
    String key=this.key;
    this.key="";
    return key;

  }


  // function to delete todo
  void deleteItem(Todo todo) async {
    final DatabaseReference database1 = FirebaseDatabase.instance.reference();
    String id=todo.id as String;
    database1.child('tasks').child(id).remove().then((_) {
      print('Task status updated successfully.');
    }).catchError((error) {
      print('Failed to update task status: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple todo app'),
      ),
      backgroundColor: const Color(0xFFF5EBFF),
      body: Column(
        children: [
          Todolist(insertFunction: addItem, deleteFunction: deleteItem,editFunction:editFunction),
          // we will add our widgets here.
          UserInput(insertFunction: addItem,update:update,getKeyFunction:getKey, ),
        ],
      ),
    );
  }
}
