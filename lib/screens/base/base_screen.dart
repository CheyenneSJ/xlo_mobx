import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';

import '../../stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pagesStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();

    reaction(
      (_) => pagesStore.page,
      (page) => pageController.jumpToPage(page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomeScreen(),
          CreateScreen(),
          Container(color: Colors.green),
          Container(color: Colors.yellow),
          Container(color: Colors.pink),
        ],
      ),
    );
  }
}
