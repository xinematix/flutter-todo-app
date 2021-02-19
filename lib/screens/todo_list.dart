import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/models/Task.dart';
import 'package:todo_app/screens/setup/database.dart';

class ToDoList extends StatefulWidget {
  ToDoList({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  // final Task task;

  @override
  Widget build(BuildContext context) {
    //access todos data
    final todos = Provider.of<List<Task>>(context);
    DateFormat dateFormat = DateFormat('E, d MMM yyyy');

    return ListView.builder(
      itemCount: checkTodosLength(todos),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: PopupMenuButton<Action>(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Delete"),
                      value: Action.delete,
                    )
                  ];
                },
                onSelected: (value) {
                  setState(() {
                    var user = FirebaseAuth.instance.currentUser;
                    DatabaseService(uid: user.uid).deleteTodo();
                  });
                },
              ),
              tileColor: checkPriority(todos[index]),
              trailing: Checkbox(
                value: todos[index].isDone,
                onChanged: (bool val) {
                  setState(() {
                    todos[index].isDone = val;
                  });
                },
                activeColor: Colors.green[600],
              ),
              title: Text(
                todos[index].task,
                style: TextStyle(
                  decoration: todos[index].isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                dateFormat.format(todos[index].deadline),
                style: TextStyle(
                  decoration: todos[index].isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

//return color code according to priority of task user selected
checkPriority(Task task) {
  if (task.priority == "High") {
    return Colors.redAccent;
  } else if (Task().priority == "Medium") {
    return Colors.orangeAccent;
  } else {
    return Colors.yellow;
  }
}

//check if todo list is null
checkTodosLength(List<Task> todos) {
  var getUsernameLength = 0;
  if (todos == null) {
    return getUsernameLength;
  } else {
    return todos.length;
  }
}

enum Action { delete, edit }
