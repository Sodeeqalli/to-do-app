import 'package:flutter/material.dart';
import 'package:todoapp/models/item_model.dart';

class ToDoAdd extends StatefulWidget {
  const ToDoAdd({super.key, required this.onSubmit});
  final void Function(String name, Priority priority, Category category)
      onSubmit;

  @override
  State<ToDoAdd> createState() {
    return _ToDoAddState();
  }
}

class _ToDoAddState extends State<ToDoAdd> {
  Priority currentPriority = Priority.high;
  Category currentCategory = Category.home;
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyBoardSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    label: Text('Item Name'),
                  ),
                ),
                Row(
                  children: [
                    DropdownButton(
                        value: currentPriority,
                        items: Priority.values
                            .map((priority) => DropdownMenuItem(
                                value: priority,
                                child: Text(priority.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          } else {
                            setState(() {
                              currentPriority = value;
                            });
                          }
                        }),
                    const Spacer(),
                    DropdownButton(
                        value: currentCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          } else {
                            setState(() {
                              currentCategory = value;
                            });
                          }
                        }),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        if (nameController.text.trim().isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text(
                                      'Make sure you type in a name'),
                                  actions: [
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Okay'))
                                  ],
                                );
                              });
                        } else {
                          widget.onSubmit(nameController.text, currentPriority,
                              currentCategory);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Submit'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
