library loading_widget;

import 'package:flutter/material.dart';

class LoadingLayout extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Widget? indicator;
  final LoadingController? controller;

  late final Widget _stackedChild = Stack(
    children: [
      child,
      _IndicatorWrapper(
        indicator: indicator,
      )
    ],
  );

  LoadingLayout(
      {Key? key,
        this.isLoading = false,
        required this.child,
        this.indicator,
        this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller ?? LoadingController.value(isLoading),
      builder: (context, val, child) =>
          _LoadingInheritedWidget(val, child: _stackedChild),
    );
  }
}

class LoadingController extends ValueNotifier<bool> {
  LoadingController.value(bool isLoading) : super(false);

  LoadingController() : super(false);
}

class _IndicatorWrapper extends StatelessWidget {
  final Widget? indicator;

  const _IndicatorWrapper({Key? key, this.indicator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myInheritedWidget = _LoadingInheritedWidget.of(context);
    return myInheritedWidget.isLoading
        ? SizedBox(
        width: context.screenWidth,
        height: context.screenHeight,
        child:
        Center(child: indicator ?? const CircularProgressIndicator()))
        : const SizedBox();
  }
}

class _LoadingInheritedWidget extends InheritedWidget {
  const _LoadingInheritedWidget(
      this.isLoading, {
        Key? key,
        required Widget child,
      }) : super(key: key, child: child);

  final bool isLoading;

  static _LoadingInheritedWidget of(BuildContext context) {
    final _LoadingInheritedWidget? result =
    context.dependOnInheritedWidgetOfExactType<_LoadingInheritedWidget>();
    assert(result != null, 'No LoadingWidget extends found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_LoadingInheritedWidget oldWidget) {
    return oldWidget.isLoading != isLoading;
  }
}

extension ContextX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;
}

