// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:coffee_menu/coffee.dart';
import 'package:get/get.dart';

class CoffeeConceptDetails extends StatelessWidget {
  const CoffeeConceptDetails({
    Key? key,
    required this.coffee,
  }) : super(key: key);
  final Coffee coffee;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
            child: Hero(
              tag: "text_${coffee.name}",
              child: Material(
                color: Colors.transparent,
                child: Text(
                  coffee.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    backgroundColor: Colors.transparent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: size.height * 0.4,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: coffee.name,
                    child: Image.asset(
                      coffee.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 0.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(-100 * value, 150 * value),
                child: child,
              );
            },
            child: Text(
              '\$${coffee.price.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 20,
                    )
                  ]),
            ),
          ).marginOnly(left: 24, top: 12),
          const Spacer(),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 0.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 180 * value),
                child: child,
              );
            },
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
              ),
              child: Text(
                'buy now'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 18, wordSpacing: 2, letterSpacing: 2),
              ),
            ).marginSymmetric(horizontal: 24, vertical: 48),
          ),
        ],
      ),
    );
  }
}
