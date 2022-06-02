import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (BuildContext context, state) {
            return !state.isGpsEnabled
                ? const _EnableGpsMessage()
                : const _AccessGpsButton();
          },
        ),
      ),
    );
  }
}

class _AccessGpsButton extends StatelessWidget {
  const _AccessGpsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: FittedBox(
            child: Text('Es necesario acceder a tu ubicación'),
          ),
        ),
        const SizedBox(height: 16),
        MaterialButton(
          shape: const StadiumBorder(),
          color: Colors.black,
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsAccess();
          },
          child: const Text(
            'Solicitar acceso',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: FittedBox(
        child: Text(
          'Debe activar el GPS para continuar',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
