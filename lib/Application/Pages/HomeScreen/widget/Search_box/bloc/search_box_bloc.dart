import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../Domain/services/Algolia_service.dart';

part 'search_box_event.dart';
part 'search_box_state.dart';

class SearchBoxBloc extends Bloc<SearchBoxEvent, SearchBoxState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final HttpsCallable _getRoutesCallable =
      FirebaseFunctions.instance.httpsCallable('getRoutes');

  SearchBoxBloc() : super(SearchBoxInitial()) {
    on<PerformSearchEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        print(
            "PerformSearchEvent data - from: ${event.from}, destination: ${event.destination}, searchTime: ${event.searchTime}");

        await _performSearch(event, emit);
      } catch (e) {
        emit(SearchErrorState(message: 'An error occurred: $e'));
      }
    });

    on<SearchSuggestionsEvent>((event, emit) async {
      emit(SuggestionLoading());
      try {
        final suggestions = await _fetchSuggestions(event.query);
        emit(SuggestionLoaded(suggestions: suggestions));
      } catch (e) {
        emit(SuggestionError(message: e.toString()));
      }
    });

    on<SearchClear>((event, emit) {
      emit(const SuggestionLoaded(suggestions: []));
    });
  }

  Future<List<String>> _fetchSuggestions(String query) async {
    if (query.isEmpty) return [];

    final Algolia algolia = AlgoliaService.instance.algolia;
    final AlgoliaQuery algoliaQuery =
        algolia.index('Stop_name').search(query);

    try {
      final AlgoliaQuerySnapshot snapshot = await algoliaQuery.getObjects();

      final suggestions = snapshot.hits
          .map((hit) {
            final routesName = hit.data['Routesname'] as List<dynamic>?;
            if (routesName != null && routesName.isNotEmpty) {
              return routesName
                  .where((route) => route
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .map((route) => route.toString())
                  .toList();
            }
            print('"Routesname" field found in Algolia hit.$routesName');
            return <String>[];
            
          }
          )
          .expand((element) => element)
          .toList();

      return suggestions;
    } catch (e) {
      throw Exception('Failed to fetch suggestions');
    }
  }

  Future<void> _performSearch(
      PerformSearchEvent event, Emitter<SearchBoxState> emit) async {
    try {
      print("_performSearch called with: "
          "from=${event.from}, destination=${event.destination}, searchTime=${event.searchTime}");

      if (event.from == null ||
          event.from.isEmpty ||
          event.destination == null ||
          event.destination.isEmpty ||
          event.searchTime == null ||
          event.searchTime.isEmpty) {
        print("Error: One or more required fields are missing.");
        emit(SearchErrorState(
            message: 'From, destination, and search time are required.'));
        return;
      }
      // Validate searchTime format (optional)
      if (!isValidTimeFormat(event.searchTime)) {
        emit(SearchErrorState(
            message: 'Invalid search time format. Expected HH:mm AM/PM.'));
        return;
      }

      emit(SearchLoadingState());

      final data = {
        "from": event.from.toString().trim(),
        "destination": event.destination.toString().trim(),
        "searchTime": event.searchTime.toString().trim()
      };
      print("Sending payload to callable: $data");

      final result = await _getRoutesCallable.call(data);

      print("Result from Cloud Function: ${result.data}");

      if (result.data != null && result.data['results'] != null) {
        final List<dynamic> results = result.data['results'];
        final filteredResults = results
            .map((route) => Map<String, dynamic>.from(route as Map))
            .toList();
        emit(SearchSuccessState(results: filteredResults));
      } else {
        emit(SearchErrorState(message: 'No results found.'));
      }
    } catch (e) {
      print("_performSearch encountered an error: $e");
      emit(SearchErrorState(message: 'An error occurred: $e'));
    }
  }
}

bool isValidTimeFormat(String timeStr) {
  // Implement your time format validation logic here
  // For example, you could use a regular expression
  return RegExp(r'^(?:[0-1][0-9]|2[0-3]):[0-5][0-9] (?:AM|PM)$')
      .hasMatch(timeStr);
}
