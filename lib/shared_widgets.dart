import 'package:flutter/material.dart';


var icon = Hero(
  tag: 'hero',
  child: CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 48.0,
    child: Image.asset(
      'assets/logo.png',
      ),
  ),
);

double getTextWidth(context) => MediaQuery.of(context).size.width * 0.8;