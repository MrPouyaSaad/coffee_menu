import 'package:coffee_menu/coffee_concept_list.dart';
import 'package:flutter/material.dart';

class MainCoffeeConceptApp extends StatelessWidget {
  const MainCoffeeConceptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: CoffeeConceptList(),
    );
  }
}
