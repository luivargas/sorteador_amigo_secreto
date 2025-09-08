import 'package:flutter/material.dart';

class ViewGroup extends StatefulWidget {
  const ViewGroup({super.key});

  @override
  State<ViewGroup> createState() => _ViewGroup();
}

class _ViewGroup extends State<ViewGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(),
    );
  }
}
