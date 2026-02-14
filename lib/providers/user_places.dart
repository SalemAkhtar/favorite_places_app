import 'dart:io';

import 'package:favorite_places_app/models/place.dart';
import 'package:flutter_riverpod/legacy.dart';

class UserPlacesNotifer extends StateNotifier<List<Place>> {
  UserPlacesNotifer() : super([]);

  void addPlace(String title, File image) {
    final newPlace = Place(title: title, image: image);
    state = [newPlace, ...state];
  }
}

final UserPlacesProvider =
    StateNotifierProvider<UserPlacesNotifer, List<Place>>(
      (ref) => UserPlacesNotifer(),
    );
