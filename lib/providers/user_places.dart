import 'package:favorite_places_app/models/place.dart';
import 'package:flutter_riverpod/legacy.dart';

class UserPlacesNotifer extends StateNotifier<List<Place>> {
  UserPlacesNotifer() : super([]);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [newPlace, ...state];
  }
}

final UserPlacesProvider =
    StateNotifierProvider<UserPlacesNotifer, List<Place>>(
      (ref) => UserPlacesNotifer(),
    );
