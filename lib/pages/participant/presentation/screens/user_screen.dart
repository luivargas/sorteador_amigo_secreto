import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/widgets/home_screen_body.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> {
  final TextEditingController searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeScreenBody(searchControler: searchControler));
  }
}
