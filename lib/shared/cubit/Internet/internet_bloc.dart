import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/enum/enum.dart';

// A Cubit (a state management class) to manage internet connectivity.
class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();

  // Subscription to monitor changes in internet connectivity.
  StreamSubscription? _connectivitySubscription;

  // Constructor for the InternetCubit class.
  InternetCubit() : super(InternetState.initial) {
// Start listening to changes in connectivity when an instance is created.
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        // If mobile or Wi-Fi connectivity is detected, emit 'gained' state.
        emit(InternetState.gained);
      } else {
        // If no mobile or Wi-Fi connectivity is detected, emit 'lost' state.
        emit(InternetState.lost);
      }
    });
  }

  @override
  Future<void> close() {
    // Cancel the connectivity subscription when this Cubit is closed.
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
