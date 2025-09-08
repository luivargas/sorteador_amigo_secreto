import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/widgets/home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final TextEditingController searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeScreenBody(searchControler: searchControler));
  }
}
