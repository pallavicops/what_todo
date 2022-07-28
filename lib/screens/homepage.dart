import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_todo/bloc/task_bloc.dart';
import 'package:what_todo/screens/taskpage.dart';
import 'package:what_todo/screens/widgets.dart';

import '../models/task.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    taskBloc.fetchAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: const Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 32.0,
                  ),
                  child: const Image(
                    image: AssetImage("assets/images/logo.png"),
                  ),
                ),
                const Taskcardwidget(
                  id: 0,
                  showDeleteButton: false,
                  title: "Get Stared!!",
                  desc:
                      "Hello User! Welcom to WHAT_TODO app. This is a default task that you can edit or delete to start using this app",
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: taskBloc.tasksStream,
                      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }
                        if (snapshot.hasData) {
                          final tasks = snapshot.data;
                          return ListView.builder(
                            itemCount: tasks?.length,
                            itemBuilder: ((context, index) => Taskcardwidget(
                                  id: tasks![index].id!,
                                  showDeleteButton: true,
                                  title: tasks[index].title,
                                  desc: tasks[index].descreption,
                                )),
                          );
                        }
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }),
                )
              ]),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const Taskpage()),
                      ),
                    ).then((value) => taskBloc.fetchAllTasks());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF7349FE), Color(0xFF643fDB)]),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Image(
                        image: AssetImage("assets/images/add_icon.png"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
