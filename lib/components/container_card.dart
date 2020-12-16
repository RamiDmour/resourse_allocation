import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
