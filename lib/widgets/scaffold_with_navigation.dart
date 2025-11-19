import 'package:flutter/material.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? ''),centerTitle: false,),
      body: child,
    );
  }
}
