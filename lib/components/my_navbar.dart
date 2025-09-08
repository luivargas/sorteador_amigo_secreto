import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sorteador_amigo_secreto/components/my_appbar.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class MyNavbar extends StatelessWidget {
  final dynamic child;
  const MyNavbar({super.key, required this.child});

  static const tabs = ['/home', '/login'];

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();

    final selectedIndex = tabs.indexWhere((path) {
      return path.startsWith(currentLocation);
    });
    return Scaffold(
      appBar: MyHomeAppBar(),
      body: child,
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.white,
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          context.go(tabs[index]);
        },
        destinations: <Widget>[
          NavigationDestination(
            label: 'Home',
            icon: Icon(Icons.home, color: Colors.white),
            selectedIcon: Icon(Icons.home, color: MyColors.sorteadorGrey),
          ),
          NavigationDestination(
            label: 'Login',
            icon: Icon(Icons.person, color: Colors.white),
            selectedIcon: Icon(Icons.person, color: MyColors.sorteadorGrey),
          ),
        ],
      ),
    );
  }
}
