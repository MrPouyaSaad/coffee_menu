import 'package:coffee_menu/coffee.dart';
import 'package:coffee_menu/coffee_concept_list.dart';
import 'package:flutter/material.dart';

class CoffeeConcept extends StatelessWidget {
  const CoffeeConcept({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -20.0) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: const CoffeeConceptList(),
                  );
                },
              ),
            );
          }
        },
        child: Stack(
          children: [
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffA89276),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   height: 140,
            //   left: 0,
            //   right: 0,
            //   bottom: -size.height * 0.25,
            //   child: Image.asset('assets/images/logo.png'),
            // ),
            Positioned(
              height: size.height * 0.4,
              left: 0,
              right: 0,
              top: size.height * 0.15,
              child: Hero(
                tag: coffees[10].name,
                child: Image.asset(
                  coffees[9].image,
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.7,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: coffees[8].name,
                child: Image.asset(
                  coffees[7].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height,
              left: 0,
              right: 0,
              bottom: -size.height * 0.8,
              child: Hero(
                tag: coffees[11].name,
                child: Image.asset(
                  coffees[10].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height / 5,
              right: 0,
              left: 0,
              bottom: size.height * 0.25,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
