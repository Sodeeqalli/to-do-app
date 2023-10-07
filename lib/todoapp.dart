import 'package:flutter/material.dart';
import 'package:todoapp/models/item_model.dart';
import 'package:todoapp/todoadd.dart';
import 'package:todoapp/todoitem.dart';

import 'package:google_fonts/google_fonts.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});
  @override
  State<ToDoApp> createState() {
    return _ToDoAppState();
  }
}

class _ToDoAppState extends State<ToDoApp> {
  final List<ItemModel> items = [
    ItemModel('Alli', Priority.high, Category.home),
    ItemModel('Sodeeq', Priority.low, Category.personal),
  ];
  int get lenght {
    final lenghtOfList = items.length;
    return lenghtOfList;
  }

  void onRemove(ItemModel item) {
    final itemIndex = items.indexOf(item);
    setState(() {
      items.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Item removed from list'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              items.insert(itemIndex, item);
            });
          }),
    ));
  }

  void onSubmit(String name, Priority priority, Category category) {
    setState(() {
      items.add(ItemModel(name, priority, category));
    });
  }

  void _addItem() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ToDoAdd(
            onSubmit: onSubmit,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Task Manager',
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            Text(
              'Add Task',
              style:
                  GoogleFonts.ubuntu(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  lenght > 1
                      ? 'You have $lenght tasks left'
                      : 'You have $lenght task left',
                  style: GoogleFonts.ubuntu(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              items.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'Add a new task today',
                          style: GoogleFonts.ubuntu(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: ((context, id) => Dismissible(
                              background: Container(
                                color: Colors.red,
                              ),
                              key: ValueKey(items[id].id),
                              onDismissed: (direction) => onRemove(items[id]),
                              child: ToDoItem(
                                isChecked: items[id].isChecked,
                                key: ValueKey(items[id].name),
                                name: items[id].name,
                                priority: items[id].priority,
                                category: items[id].category,
                              ),
                            )),
                      ),
                    ),
            ],
          ),
        ));
  }
}
