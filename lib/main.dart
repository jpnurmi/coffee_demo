import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart' as yaru;

import 'cloud_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee demo',
      theme: yaru.lightTheme,
      home: const CloudProviderPage(),
    );
  }
}
