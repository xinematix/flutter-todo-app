import 'package:flutter/material.dart';
import 'package:todo_app/screens/setup/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/todo_list.dart';
import 'package:todo_app/screens/models/Task.dart';
import 'package:todo_app/drawer.dart';
import 'NewTask.dart';
import 'about.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  // List currentTodos = List<Todo>();
  String title = "Todo App";
  int index = 0;
  List<Widget> list = [
    ToDoApp(),
    About(),
  ];

  String input = "";

  @override
  Widget build(BuildContext context) {
    // final myToDos = Provider.of<MyToDos>(context);
    return StreamProvider<List<Task>>.value(
      value: DatabaseService().tasks,
      catchError: (context, error) {
        print(error);
        return error;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Tasks'),
          // title: Text('My Tasks'),
          backgroundColor: Colors.deepPurple,
        ),
        body: ToDoList(),
        drawer: MyDrawer(
          onTap: (context, i, txt) {
            setState(() {
              index = i;
              title = txt;
              Navigator.pop(context);
            });
          },
          user: widget.user,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewTask()));
          },
          child: Icon(Icons.add),
          elevation: 8,
        ),
      ),
    );
  }
}

List<Todo> currentTodos = [
  Todo(task: 'task 1', urgency: 'urgent'),
  Todo(task: 'task 2', urgency: 'not urgent'),
  Todo(task: 'task 3', urgency: 'urgent'),
  Todo(task: 'task 4', urgency: 'urgent'),
];

class Todo {
  final String task;
  bool isDone;
  final String urgency;

  Todo({this.task, this.isDone = false, this.urgency});
}

final todos = [
  Todo(task: 'task 1', urgency: 'urgent'),
  Todo(task: 'task 2', urgency: 'not urgent'),
];
