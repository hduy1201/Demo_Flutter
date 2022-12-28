import 'package:flutter/cupertino.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Setting Page'),
    );
  }
}
