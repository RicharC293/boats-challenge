import 'dart:math';

import 'package:boats_challenge/Data/boats_data_model.dart';
import 'package:boats_challenge/UI/second_page.dart';
import 'package:boats_challenge/UI/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom(),
            PageViewBoats(),
          ],
        ),
      ),
    );
  }
}

class PageViewBoats extends StatefulWidget {
  @override
  _PageViewBoatsState createState() => _PageViewBoatsState();
}

class _PageViewBoatsState extends State<PageViewBoats> {
  final _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  final _scrollNotifier = ValueNotifier(0.0);

  void _listener() {
    _scrollNotifier.value = _pageController.page;
  }

  @override
  void initState() {
    _pageController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.removeListener(_listener);
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<double>(
        valueListenable: _scrollNotifier,
        builder: (_, scroll, __) => PageView.builder(
          controller: _pageController,
          itemCount: boats.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            final _percentLeft = (-scroll + index + 1).clamp(0.0, 1.0);
            final _percentRight = (scroll - index + 1).clamp(0.0, 1.0);
            final _percentScaleLeft =
                pow((-scroll + index + 1).clamp(0.0, 1.0), 0.5);
            final _percentScaleRight =
                pow((scroll - index + 1).clamp(0.0, 1.0), 0.5);
            return Transform.scale(
              scale: _percentRight < 1 ? _percentScaleRight : _percentScaleLeft,
              child: Opacity(
                opacity: _percentRight < 1 ? _percentRight : _percentLeft,
                child: Column(
                  children: [
                    Image.asset(
                      boats[index].image,
                      height: MediaQuery.of(context).size.height * 0.65,
                    ),
                    Text(
                      boats[index].name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.subtitle2,
                        children: [
                          TextSpan(text: 'By '),
                          TextSpan(
                              text: '${boats[index].maker}',
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SecondPage(
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SPEC',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.blueAccent,
                            )
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Boats',
              style: TextStyle(fontSize: 30),
            ),
            Spacer(),
            Icon(Icons.search),
            const SizedBox(width: 20),
            GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SettingsPage())),
                child: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
