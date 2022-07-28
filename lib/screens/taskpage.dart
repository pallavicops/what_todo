import 'package:flutter/material.dart';
import 'package:what_todo/bloc/task_bloc.dart';
import 'package:what_todo/models/task.dart';
import 'package:what_todo/screens/widgets.dart';

class Taskpage extends StatefulWidget {
  const Taskpage({Key? key}) : super(key: key);

  @override
  State<Taskpage> createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  final TextEditingController _descriptionController =
      TextEditingController(text: '');
  String title = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 6.0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Image(
                              image: AssetImage(
                                  "assets/images/back_arrow_icon.png")),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            title = value;
                          },
                          onSubmitted: (value) {
                            print("Fild value: $value");

                            if (value != "") {
                              final id = DateTime.now().millisecondsSinceEpoch;

                              Task newTask = Task(
                                id: id,
                                title: title,
                                descreption: _descriptionController.text,
                              );

                              taskBloc.insertTask(newTask);

                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter your task"),
                                ),
                              );
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter Taks Title",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211551),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    onSubmitted: (value) {
                      print("Fild value: $value");

                      if (value != "") {
                        final id = DateTime.now().millisecondsSinceEpoch;

                        Task newTask = Task(
                          id: id,
                          title: title,
                          descreption: _descriptionController.text,
                        );

                        taskBloc.insertTask(newTask);

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter your description"),
                          ),
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Description for the task",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                    ),
                  ),
                ),
                const Todowidget(
                  text: "Creat your first Task",
                  isDone: true,
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
