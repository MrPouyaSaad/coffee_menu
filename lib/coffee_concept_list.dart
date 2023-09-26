import 'package:coffee_menu/coffee.dart';
import 'package:flutter/material.dart';

final _duration = Duration(milliseconds: 250);

class CoffeeConceptList extends StatefulWidget {
  const CoffeeConceptList({super.key});

  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  final pageCoffeeContorller = PageController(
    viewportFraction: 0.35,
  );
  final pageTextController = PageController();
  double currectPage = 0;
  double textPage = 0;
  void _coffeeScrollListener() {
    setState(() {
      currectPage = pageCoffeeContorller.page!;
    });
  }

  void _textScrollListener() {
    setState(() {
      textPage = currectPage;
    });
  }

  @override
  void initState() {
    pageCoffeeContorller.addListener(_coffeeScrollListener);
    pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    pageCoffeeContorller.removeListener(_coffeeScrollListener);
    pageTextController.removeListener(_textScrollListener);
    pageCoffeeContorller.dispose();
    pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    offset: Offset.zero,
                    spreadRadius: 45,
                  )
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: pageCoffeeContorller,
              scrollDirection: Axis.vertical,
              onPageChanged: (value) {
                if (value < coffees.length) {
                  pageTextController.animateToPage(value,
                      duration: _duration, curve: Curves.easeOut);
                }
              },
              itemCount: coffees.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final coffee = coffees[index - 1];
                final result = currectPage - index + 1;
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(
                        0.0,
                        size.height / 2.6 * (1 - value).abs(),
                      )
                      ..scale(value),
                    child: Opacity(
                      opacity: opacity,
                      child: Image.asset(
                        coffee.image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 110,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageTextController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: coffees.length,
                    itemBuilder: (context, index) {
                      final opacity =
                          (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                      return Opacity(
                        opacity: opacity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.2,
                          ),
                          child: Text(
                            coffees[currectPage.toInt()].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AnimatedSwitcher(
                  duration: _duration,
                  child: Text(
                    '\$ ${coffees[currectPage.toInt()].price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    key: Key(coffees[currectPage.toInt()].name),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
