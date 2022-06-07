import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/models/models.dart';

import '../blocs/blocs.dart';
import '../delegates/delegates.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : FadeInDown(
                from: 100,
                child: const _SearchBarBody(),
              );
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  void onSearchResult(BuildContext context, SearchResult result) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: SearchDestinationDelegate(),
            );
            if (result == null) return;

            onSearchResult(context, result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: const Text(
              "¿Donde quieres ir?",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
