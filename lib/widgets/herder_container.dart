import 'package:challenge_hmv/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  var text = "Login";

  HeaderContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [azulHmv, azulHmv],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [Image.asset("assets/logo.jpeg")],
      ),
      padding: const EdgeInsets.only(bottom: 30)
    );
  }
}
