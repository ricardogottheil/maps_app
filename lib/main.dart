import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/screens/screens.dart';

import 'blocs/blocs.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<GpsBloc>(
      create: (context) => GpsBloc(),
    ),
  ], child: const MapApp()));
}

class MapApp extends StatelessWidget {
  const MapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: LoadingScreen(),
    );
  }
}
