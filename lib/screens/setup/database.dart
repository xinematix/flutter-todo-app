import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/screens/models/Task.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection("todos");

  Future updateTodos(String task, String priority, DateTime deadline,
      String category, bool isDone) async {
    return await todoCollection.doc(uid).set({
      'task': task,
      'priority': priority,
      'deadline': deadline,
      'category': category,
      'isDone': isDone,
    });
  }

  Future addTodo(String task, String priority, DateTime deadline,
      String category, bool isDone) async {
    return await todoCollection.add({
      'task': task,
      'priority': priority,
      'deadline': deadline,
      'category': category,
      'isDone': isDone,
    });
  }

  Future deleteTodo() async {
    return await todoCollection.doc(uid).delete();
  }

  //Get todo list from snapshot
  List<Task> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task(
        task: doc.data()['task'] ?? '',
        priority: doc.data()['priority'] ?? '',
        deadline: doc.data()['deadline'].toDate() ?? DateTime.now(),
        category: doc.data()['category'] ?? '',
        isDone: doc.data()['isDone'] ?? false,
      );
    }).toList();
  }

  //Call todo stream to get updated database
  Stream<List<Task>> get tasks {
    return todoCollection.snapshots().map((_todoListFromSnapshot));
  }

  // String readTimestamp(Timestamp timestamp) {

  // }
}
