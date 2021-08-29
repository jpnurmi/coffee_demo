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
  PageController? _controller;
  int? _current;
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
  void didChangeDependencies() {
    _current = ModalRoute.of(context)!.settings.arguments as int;
    _controller?.dispose();
    _controller = PageController(initialPage: _current!);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _updateCurrent(int current) {
    _restartTimer();
    setState(() => _current = current);
  }

  void _next() {
    _restartTimer();
    if (_current! < kSlides.length - 1) {
      _controller!.animateToPage(
        _current = _current! + 1,
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
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          NotificationListener<OverscrollNotification>(
            onNotification: (overscroll) {
              if (overscroll.overscroll > 0) {
                _next();
              }
              return true;
            },
            child: PageView(
              controller: _controller,
              onPageChanged: _updateCurrent,
              children: kSlides.map((asset) => _AssetImage(asset)).toList(),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: kPadding,
            child: Center(
              child: SmoothPageIndicator(
                count: kSlides.length,
                controller: _controller!,
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
