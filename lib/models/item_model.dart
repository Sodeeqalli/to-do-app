import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ItemModel {
  ItemModel(this.name, this.priority, this.category)
      : id = uuid.v4(),
        isChecked = false;
  final String id;
  final String name;
  final Priority priority;
  final Category category;
  bool isChecked;
}

enum Priority { high, medium, low }

const priorityIcon = {
  Priority.high: Icons.priority_high_outlined,
  Priority.medium: Icons.list_alt_outlined,
  Priority.low: Icons.low_priority_outlined,
};

enum Category { school, work, home, shopping, personal, gym }

const categoryIcon = {
  Category.gym: Icons.sports_gymnastics,
  Category.school: Icons.school,
  Category.work: Icons.work,
  Category.home: Icons.home,
  Category.shopping: Icons.shopify,
  Category.personal: Icons.self_improvement,
};

const priorityColor = {
  Priority.high: Color.fromARGB(255, 143, 10, 0),
  Priority.medium: Color.fromARGB(255, 0, 4, 255),
  Priority.low: Color.fromARGB(255, 9, 85, 0)
};
List<Map<String, dynamic>> items = [
  {
    "name": "name",
    "checked": false,
  }
];
