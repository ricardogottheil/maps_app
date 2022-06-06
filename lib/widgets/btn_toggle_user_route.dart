import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class BtnToggleUserRoute extends StatelessWidget {
  const BtnToggleUserRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.more_horiz_rounded),
          onPressed: () {
            mapBloc.add(OnToggleUserRoute());
          },
        ),
      ),
    );
  }
}
