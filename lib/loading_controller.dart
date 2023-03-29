import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_layout/loading_layout.dart';

/// The controller to control [LoadingLayout] (show/hide/display duration, etc.)
class LoadingController extends ValueNotifier<bool> {
  /// `isLoading` is initial value of loading status. Defaults to false
  LoadingController(
      {bool isLoading = false, this.displayDuration, this.onDisplayTimeout})
      : super(isLoading) {
    value = isLoading;
  }

  /// Duration of displaying [LoadingLayout]. Null value represents loading
  /// indeterminately.
  final int? displayDuration;
  /// The callback fired when non-null `displayDuration` runs out.
  final Function? onDisplayTimeout;

  /// Internal time to fire `onDisplayTimeout` when non-null `displayDuration`
  /// runs out.
  Timer? _timer;

  /// This will update loading status and notifies it to [LoadingLayout].
  /// If `displayDuration` is non-null, then will start time when loading or
  /// cancel it otherwise.
  @override
  set value(bool newValue) {
    if (displayDuration != null) {
      if (newValue) {
        _scheduleTimer();
      } else {
        _timer?.cancel();
      }
    }
    super.value = newValue;
  }

  void _scheduleTimer() {
    if (displayDuration == null) return;
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: displayDuration!), () {
      value = false;
      onDisplayTimeout?.call();
    });
  }

  @override
  dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
