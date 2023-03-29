library loading_widget;

import 'package:flutter/material.dart';

import 'loading_controller.dart';

/// This widget is used to display loading indicator in the center of [child]
/// widget.
///
/// If you don't want to create Stack widget with contains loading
/// indicator and primary view; or show the loading indicator using a dialog,
/// which you have to manage its visibility for cases such as the screen goes
/// to background.
/// Then the widget will be helpful.
///
/// You can also use [LoadingController] to control the this widget.
/// (show/hide/display duration)
class LoadingLayout extends StatelessWidget {
  /// The primary widget that the [indicator] will shown on the top of it.
  final Widget child;

  /// The loading indicator. If it is null, then [CircularProgressIndicator]
  /// will be used instead.
  final Widget? indicator;

  /// The flag to determine if the this widget will be invisible when user
  /// taps on screens.
  final bool dismissOnTap;

  /// The callback that is fired when user taps on screens and [dismissOnTap] is
  /// set to true
  final Function? onDismissTap;

  /// The callback that is fired when the loading status is changed. It
  /// provides the `value` representing the loading status.
  final Function(bool? value)? onToggleChanged;

  /// The controller will be used to control the this widget
  /// (show/hide/display duration, etc.).
  final LoadingController _controller;

  /// Creates the widget without providing [LoadingController] explicitly.
  /// A internal [LoadingController] will be created.
  ///
  /// The `isLoading` is initial loading status value
  /// and it will be passed to the internal [LoadingController]'s constructor.
  ///
  /// The `displayDuration` is duration of displaying this widget. After
  /// the duration runs out, it will be invisible. If the value is null, that
  /// means there is no duration and this widget will be displayed forever,
  /// It will be passed to the internal [LoadingController]'s
  /// constructor.
  ///
  /// `onDisplayTimeOut` is the callback fired when the `displayDuration`
  /// run outs. If `displayDuration` is null then the callback is never fired.
  /// It will be passed to the internal [LoadingController]'s
  //  constructor.
  LoadingLayout({
    Key? key,
    bool isLoading = false,
    required this.child,
    this.indicator,
    this.dismissOnTap = false,
    this.onDismissTap,
    this.onToggleChanged,
    int? displayDuration,
    Function? onDisplayTimeOut,
  })  : _controller = LoadingController(
            isLoading: isLoading,
            displayDuration: displayDuration,
            onDisplayTimeout: onDisplayTimeOut),
        super(key: key);

  /// Creates the widget, you need to provide [LoadingController] explicitly.
  ///
  /// The `controller` is [LoadingController] needed to control this widget.
  const LoadingLayout.withController({
    Key? key,
    required this.child,
    this.indicator,
    required LoadingController controller,
    this.dismissOnTap = false,
    this.onDismissTap,
    this.onToggleChanged,
  })  : _controller = controller,
        super(key: key);

  /// Build the widget.
  /// It contains [GestureDetector] to implement `onDismissTap` feature and
  /// stack widget to show the `child` and the `indicator` on top of it.
  /// `indicator` is wrapped by [ValueListenableBuilder] listening
  /// loading status from the controller and pass data to it, `onToggleChanged`
  /// callback is fired also.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dismissOnTap
          ? () {
              if (_controller.value) {
                _controller.value = false;
                onDismissTap?.call();
              }
            }
          : null,
      child: Stack(
        children: [
          child,
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, val, child) {
              onToggleChanged?.call(val);
              return _IndicatorWrapper(
                indicator: indicator,
                loading: val,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// This widget is used to show/hide the indicator.
class _IndicatorWrapper extends StatelessWidget {
  final Widget? indicator;
  final bool loading;

  const _IndicatorWrapper({Key? key, this.indicator, required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: loading
          ? Center(child: indicator ?? const CircularProgressIndicator())
          : const SizedBox(),
    );
  }
}
