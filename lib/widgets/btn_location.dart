import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/ui/ui.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {
            final location = locationBloc.state.lastKnownLocation;

            if (location == null) {
              final snackBar =
                  CustomSnackbar(message: 'Localización no disponible');
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }
            mapBloc.moveCamera(location);
          },
        ),
      ),
    );
  }
}
