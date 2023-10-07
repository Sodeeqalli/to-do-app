import 'package:flutter/material.dart';

class Tick extends StatefulWidget {
  const Tick({
    super.key,
  });

  @override
  State<Tick> createState() {
    return _TickState();
  }
}

class _TickState extends State<Tick> {
  bool _done = false;
  void tick(bool? yes) {
    setState(() {
      _done = yes ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: _done, onChanged: tick);
  }
}
