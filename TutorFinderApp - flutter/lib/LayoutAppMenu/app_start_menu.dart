import 'package:firebaseconnations/Componet/side_bar.dart';
import 'package:flutter/material.dart';

class AppStartMenu extends StatelessWidget {
  const AppStartMenu({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    late List<Widget> childrens = children;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage('images/homeK.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: DrawerSideBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: childrens,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
