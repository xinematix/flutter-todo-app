import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/setup/database.dart';

// import '../main.dart';

class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
        backgroundColor: Colors.deepPurple,
      ),
      body: AddnewTask(),
    );
  }
}

class AddnewTask extends StatefulWidget {
  // final Todo myNewTask;
  // final Function func;
  const AddnewTask({Key key}) : super(key: key);

  @override
  _AddnewTaskState createState() => _AddnewTaskState();
}

class _AddnewTaskState extends State<AddnewTask> {
  // Todo myNewTask;
  // _AddnewTaskState(this.myNewTask);
  String priority = "";
  String task = "";
  bool isPressedHigh = false;
  bool isPressedMed = false;
  bool isPressedLow = false;

  DateTime _dateTime;
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  List<String> _categories = ['School', 'Workout', 'Personal', 'Family'];
  String _selectedcategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              // maxLines: 2,
              decoration: InputDecoration(
                hintText: "Task Title",
                filled: true,
                fillColor: Colors.grey[300],
                border: InputBorder.none,
              ),
              onChanged: (String value) {
                task = value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Priority",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            //Select priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //High priority
                FlatButton(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "High",
                    style: TextStyle(fontSize: 16),
                  ),
                  textColor: isPressedHigh ? Colors.white : Colors.red[400],
                  color: isPressedHigh ? Colors.red[400] : Colors.white,
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.red[400], width: 1.5)),
                  onPressed: () {
                    setState(() {
                      //set isPressed to true
                      isPressedHigh = !isPressedHigh;
                      priority = 'High';
                    });
                  },
                ),
                //Medium priority
                FlatButton(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Medium",
                    style: TextStyle(fontSize: 16),
                  ),
                  textColor: isPressedMed ? Colors.white : Colors.orange[700],
                  color: isPressedMed ? Colors.orange[700] : Colors.white,
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.orange[700], width: 1.5)),
                  onPressed: () {
                    setState(() {
                      //set isPressed to true
                      isPressedMed = !isPressedMed;
                      priority = 'Medium';
                    });
                  },
                ),
                //Low priority
                FlatButton(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Low",
                    style: TextStyle(fontSize: 16),
                  ),
                  textColor: isPressedLow ? Colors.white : Colors.yellow[700],
                  color: isPressedLow ? Colors.yellow[700] : Colors.white,
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.yellow[700], width: 1.5)),
                  onPressed: () {
                    setState(() {
                      //set isPressed to true
                      isPressedLow = !isPressedLow;
                      priority = 'Low';
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            //Select date
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 26,
                ),
                SizedBox(
                  width: 8,
                ),
                FlatButton(
                  child: Text(
                    _dateTime == null
                        ? dateFormat.format(now)
                        : dateFormat.format(_dateTime),
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate:
                          _dateTime == null ? DateTime.now() : _dateTime,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2025),
                    ).then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  },
                  highlightColor: Colors.indigoAccent,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            //Select category
            Row(
              children: [
                Icon(
                  Icons.list,
                  size: 26,
                ),
                SizedBox(
                  width: 8,
                ),
                DropdownButton(
                  hint: Text(
                    'Category',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: _selectedcategory,
                  items: _categories.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (selectedCat) {
                    setState(() {
                      _selectedcategory = selectedCat;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            //Add Task button
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Add Task",
                    style: TextStyle(fontSize: 20),
                  ),
                  textColor: Colors.white,
                  color: Colors.indigo,
                  onPressed: () {
                    setState(() {
                      var user = FirebaseAuth.instance.currentUser;
                      DatabaseService(uid: user.uid).addTodo(
                          task, priority, _dateTime, _selectedcategory, false);
                    });
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
