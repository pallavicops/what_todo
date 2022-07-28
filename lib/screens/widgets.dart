import 'package:flutter/material.dart';
import 'package:what_todo/bloc/task_bloc.dart';

class Taskcardwidget extends StatelessWidget {
  const Taskcardwidget(
      {Key? key,
      this.title,
      this.desc,
      required this.showDeleteButton,
      required this.id})
      : super(key: key);
  final int id;

  final String? title;
  final String? desc;
  final bool showDeleteButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title ?? "(UntTitle)",
              style: const TextStyle(
                color: Color(0xFF211551),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Text(
                desc ?? " NOt added ",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF868290),
                  height: 1.5,
                ),
              ),
            ),
          ]),
          Visibility(
            visible: showDeleteButton,
            child: InkWell(
              onTap: () => taskBloc.deleteTask(id),
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFFE3577),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Image(
                  image: AssetImage("assets/images/delete_icon.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Todowidget extends StatelessWidget {
  const Todowidget({Key? key, this.text, required this.isDone})
      : super(key: key);
  final String? text;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Row(
          children: [
            Container(
              width: 20.0,
              height: 20.0,
              margin: const EdgeInsets.only(
                right: 12.0,
              ),
              decoration: BoxDecoration(
                  color: isDone ? const Color(0xFF7349FE) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.0),
                  border: isDone
                      ? null
                      : Border.all(
                          color: const Color(0xFF86829D),
                        )),
              child: const Image(
                  image: AssetImage("assets/images/check_icon.png")),
            ),
            Text(
              text ?? "(Unmaned Todo )",
              style: TextStyle(
                color:
                    isDone ? const Color(0xFF211551) : const Color(0xFF86829D),
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ));
  }
}
