import 'package:flutter/material.dart';
import 'package:todoapp/models/item_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'checkbox.dart';

class ToDoItem extends StatelessWidget {
  ToDoItem(
      {super.key,
      required this.name,
      required this.priority,
      required this.isChecked,
      required this.category});
  final String name;
  final Priority priority;
  bool isChecked;
  final Category category;

  void tick(bool? yes) {
    isChecked = yes ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(children: [
        Tick(
          key: ValueKey(name),
        ),
        Icon(
          categoryIcon[category],
          color: priorityColor[priority],
        ),
        Text(
          name.toString().toUpperCase(),
          style: GoogleFonts.ubuntu(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: priorityColor[priority]),
        ),
      ]),
    );
  }
}
