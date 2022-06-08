import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate()
      : super(
          searchFieldLabel: 'Buscar...',
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        final result = SearchResult(
          cancel: true,
        );

        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity =
        BlocProvider.of<LocationBloc>(context).state.lastKnownLocation!;
    searchBloc.getPlacesByQuery(proximity, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        final places = state.places;

        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (context, i) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            final place = places[index];

            return ListTile(
              title: Text(place.text),
              subtitle: Text(place.placeName),
              leading: const Icon(Icons.place_outlined),
              onTap: () {
                final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center[1], place.center[0]),
                  name: place.text,
                  description: place.placeName,
                );

                searchBloc.add(AddToHistoryEvent(place));

                close(context, result);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title: const Text('Colocar la ubicación manualmente'),
          onTap: () {
            final result = SearchResult(
              cancel: false,
              manual: true,
            );

            close(context, result);
          },
        ),
        ...searchBloc.state.history.map((place) {
          return ListTile(
            title: Text(place.text),
            subtitle: Text(place.placeName),
            leading: const Icon(Icons.history_outlined),
            onTap: () {
              final result = SearchResult(
                cancel: false,
                manual: false,
                position: LatLng(place.center[1], place.center[0]),
                name: place.text,
                description: place.placeName,
              );

              close(context, result);
            },
          );
        }),
      ],
    );
  }
}
