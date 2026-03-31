import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/screens/home_screen.dart';
import 'package:sorteador_amigo_secreto/pages/nav_bar/presentation/screens/onboarding.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class MyNavbar extends StatefulWidget {
  final List<AuthGroupModel> groups;
  const MyNavbar({super.key, required this.groups});

  @override
  State<MyNavbar> createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  final Color colors = MyColors.neutral100;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != currentPage && mounted) {
        changePage(value);
      }
    });
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomBar(
        fit: StackFit.expand,
        icon: (width, height) => Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: colors,
              size: width,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(500),
        duration: Duration(seconds: 0),
        curve: Curves.decelerate,
        showIcon: true,
        width: 250,
        barColor: MyColors.sorteadorOrange.withAlpha(180),
        start: 2,
        end: 0,
        offset: 10,
        barAlignment: Alignment.bottomCenter,
        iconHeight: 35,
        iconWidth: 35,
        body: (context, controller) => TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.start,
          children: [
            Onboarding(),
            HomeScreen(groups: widget.groups),
          ],
        ),
        child: TabBar(
          dividerColor: Colors.transparent,
          splashBorderRadius: BorderRadius.circular(50),
          indicatorPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          controller: tabController,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: colors, width: 4),
            insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
          ),
          tabs: [
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                child: Icon(
                  Icons.home,
                  color: colors
                ),
              ),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                child: Icon(
                  Icons.group,
                  color: colors
                ),
              ),
            ),
          ],
        ),
    );
  }
}
