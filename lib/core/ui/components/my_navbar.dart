import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/presentation/screens/access.dart';
import 'package:sorteador_amigo_secreto/pages/home_screen/presentation/screens/home_screen.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({super.key});

  @override
  State<MyNavbar> createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  final Color colors = Colors.white;

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
    final Color unselectedColor = Colors.white;
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: BottomBar(
          fit: StackFit.expand,
          icon: (width, height) => Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: null,
              icon: Icon(
                Icons.arrow_upward_rounded,
                color: unselectedColor,
                size: width,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(500),
          duration: Duration(seconds: 0),
          curve: Curves.decelerate,
          showIcon: true,
          width: MediaQuery.of(context).size.width * 0.6,
          barColor: MyColors.sorteadorOrange,
          start: 2,
          end: 0,
          offset: 10,
          barAlignment: Alignment.bottomCenter,
          iconHeight: 35,
          iconWidth: 35,
          reverse: false,
          hideOnScroll: true,
          scrollOpposite: false,
          respectSafeArea: true,
          onBottomBarHidden: () {},
          onBottomBarShown: () {},
          body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: [Access(), HomeScreen()],
          ),
          child: TabBar(
            dividerColor: Colors.transparent,
            dividerHeight: 0,
            splashBorderRadius: BorderRadius.circular(50),
            indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
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
                    color: currentPage == 0 ? colors : unselectedColor,
                  ),
                ),
              ),
              SizedBox(
                height: 55,
                width: 40,
                child: Center(
                  child: Icon(
                    Icons.group,
                    color: currentPage == 1 ? colors : unselectedColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
