import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo_model.dart';

class UserInput extends StatelessWidget {
  final textController = TextEditingController();
  final Function insertFunction;
  final Function getKeyFunction;
  final Function update;// this will receive the addItem function
  UserInput({required this.insertFunction, Key? key,
    required this.update,Key?todo,
  required this.getKeyFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String key=getKeyFunction();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      // color: const Color(0xFFDAB5FF),
      child: Row(
        children: [
          // this will be the input box
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: textController,
                decoration:  InputDecoration(
                  hintText: key==null ? 'add new todo' : 'update todo',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // this will be the button
          GestureDetector(
            onTap: () {
              // create a todo
              DateTime now=DateTime.now();
              String date=DateFormat('yyyy-MM-dd – kk:mm').format(now);
              var myTodo = Todo(
                  title: textController.text,
                  creationDate:date,
                  isChecked: false);
              // pass this to the insertfunction as parameter
              if(key.isEmpty)
                insertFunction(myTodo);
              else
                {
                  myTodo.id=key;
                  update(myTodo);
                }

            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
