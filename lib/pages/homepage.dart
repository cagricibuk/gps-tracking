import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../helpers/gps.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GPS _gps = GPS();
  Position? _userPosition;
  Exception? _exception;

  void _handlePositionStream(Position position) {
    setState(() {
      _userPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(_userPosition.toString())),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _gps.startPositionStream(_handlePositionStream);
  }
}
