import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'constants.dart';
import 'routes.dart';

class SlideShowPage extends StatefulWidget {
  const SlideShowPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const SlideShowPage();

  @override
  State<SlideShowPage> createState() => _SlideShowPageState();
}

class _SlideShowPageState extends State<SlideShowPage> {
  final _controller = PageController();
  var _current = 0;
  Timer? _timer;

  void _restartTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(kSlideDelay, (_) => _next());
  }

  @override
  void initState() {
    super.initState();
    _restartTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_current < kSlides.length - 1) {
      _restartTimer();
      _controller.animateToPage(
        ++_current,
        duration: kSlideAnimation,
        curve: kSlideCurve,
      );
    } else {
      _timer?.cancel();
      Navigator.of(context).pushNamed(Routes.brewCoffee);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) => setState(() => _current = page),
            children: kSlides.map((asset) => _AssetImage(asset)).toList(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: kPadding,
            child: Center(
              child: SmoothPageIndicator(
                count: kSlides.length,
                controller: _controller,
                effect: ColorTransitionEffect(
                  dotColor: Theme.of(context).highlightColor,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetImage extends StatelessWidget {
  const _AssetImage(this.asset, {Key? key}) : super(key: key);

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4 * kPadding),
      child: asset.endsWith('.svg')
          ? SvgPicture.asset('assets/$asset', fit: BoxFit.contain)
          : Image.asset('assets/$asset', fit: BoxFit.contain),
    );
  }
}
