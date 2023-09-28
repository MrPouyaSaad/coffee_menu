import 'package:coffee_menu/coffee.dart';
import 'package:coffee_menu/coffee_concept_details.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 250);
const _initialPage = 10.0;

class CoffeeConceptList extends StatefulWidget {
  const CoffeeConceptList({super.key});

  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  final pageCoffeeContorller = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );
  final pageTextController = PageController(
    initialPage: _initialPage.toInt(),
  );
  double currectPage = _initialPage;
  double textPage = _initialPage;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 650),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: CoffeeConceptDetails(coffee: coffee),
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
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
                        child: Hero(
                          tag: coffee.name,
                          child: Image.asset(
                            coffee.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
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
            height: 100,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              duration: _duration,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0.0, -100 * value),
                  child: child,
                );
              },
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
                            child: Hero(
                              tag: "text_${coffees[index].name}",
                              child: Material(
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
          ),
        ],
      ),
    );
  }
}
