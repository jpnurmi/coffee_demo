import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service.dart';
import '../constants.dart';
import '../routes.dart';
import 'brew_model.dart';
import 'brew_widgets.dart';

const kSlides = <String>[
  'Swipe left to know more about the open source technologies we used to build this project.',
  'Slide 2',
  'Slide 3',
];

const kSlideCurve = Curves.easeInOut;
const kSlideAnimation = Duration(milliseconds: 250);

class BrewScreen extends StatefulWidget {
  const BrewScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<Service>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => BrewModel(service, kSlides.length),
      child: const BrewScreen(),
    );
  }

  @override
  State<BrewScreen> createState() => _BrewScreenState();
}

class _BrewScreenState extends State<BrewScreen> {
  PageController? _controller;

  @override
  void initState() {
    super.initState();

    final model = Provider.of<BrewModel>(context, listen: false);
    model.init(
      onSlide: _animateTo,
      onSuccess: () => Navigator.of(context).pushNamed(Routes.result),
      onFailure: () => _showError(model.error),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void didChangeDependencies() {
    _controller?.dispose();
    final model = Provider.of<BrewModel>(context, listen: false);
    _controller = PageController(initialPage: model.slide);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _animateTo(int page) {
    _controller!.animateToPage(
      page,
      curve: kSlideCurve,
      duration: kSlideAnimation,
    );
  }

  void _next() {
    final model = Provider.of<BrewModel>(context, listen: false);
    _animateTo(model.next());
  }

  void _previous() {
    final model = Provider.of<BrewModel>(context, listen: false);
    _animateTo(model.previous());
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<BrewModel>(context);
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MouseDragScrollBehavior(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: PageView(
                controller: _controller,
                physics: const AlwaysScrollableScrollPhysics(),
                onPageChanged: model.setSlide,
                children: kSlides.map((label) => BrewSlide(label)).toList(),
              ),
            ),
            if (model.isBusy)
              const Positioned(
                top: kPadding,
                right: kPadding * 4,
                child: CircularProgressIndicator(),
              ),
            Positioned(
              top: 0,
              bottom: 0,
              left: kSpacing,
              child: IconButton(
                onPressed: model.hasPrevious ? _previous : null,
                icon: const Icon(Icons.chevron_left),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: kSpacing,
              child: IconButton(
                onPressed: model.hasNext ? _next : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ),
            Positioned(
              top: kPadding,
              left: kPadding,
              right: kPadding,
              bottom: kPadding,
              child: Column(
                children: <Widget>[
                  Text(
                    'We are brewing your infrastructure',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: model.isBusy ? null : model.makeCoffee,
                    child: const Text('Make coffee!'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
