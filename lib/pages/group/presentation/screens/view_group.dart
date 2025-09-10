import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/view_group/view_group_body.dart';

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
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300,
              maxWidth: 600,
              minHeight: 400,
              maxHeight: 800,
            ),
            child: ViewGroupBody(
            ),
          ),
        ),
      ),
    );
  }
}
