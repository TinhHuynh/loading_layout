# Loading Widget

The easy way to show loading indicators in your Flutter app!
With this package, you can easily show loading indicators on your app without having to add
boilerplate code like a stack widget. Plus, the widget is highly customizable, allowing you to
integrate third-party loading indicators or your self-made ones.

## Installing

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  loading_widget: ^latest
```

## Import

```dart
import 'package:loading_widget/loading_widget.dart';
```

## How to use

```dart
import 'package:flutter/material.dart';
import 'package:loading_layout/loading_layout.dart';

class SimplePage extends StatefulWidget {
  const SimplePage({Key? key}) : super(key: key);

  @override
  State<SimplePage> createState() => _SimplePageState();
}

class _SimplePageState extends State<SimplePage> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingLayout(
          displayDuration: 3000,
          dismissOnTap: true,
          onDismissTap: () {
            print('OnDismiss');
            setState(() {
              isLoading = false;
            });
          },
          onDisplayTimeOut: () {
            isLoading = false; setState(() {
              isLoading = false;
            });
            print('onDisplayTimeOut');
          },
          onToggleChanged: (val) {
            print('onToggleChanged $val');
          },
          isLoading: isLoading,
          child: Scaffold(
            body: Container(),
            floatingActionButton: FloatingActionButton(
                child: Icon(isLoading ? Icons.toggle_off : Icons.toggle_on),
                onPressed: () {
                  setState(() {
                    isLoading = !isLoading;
                  });
                }),
          )),
    );
  }
}
```

* Use loading_controller

```dart
import 'package:flutter/material.dart';
import 'package:loading_layout/loading_controller.dart';
import 'package:loading_layout/loading_layout.dart';

class WithControllerPage extends StatelessWidget {
  WithControllerPage({Key? key}) : super(key: key);
  final LoadingController _controller = LoadingController(
    displayDuration: 3000,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoadingLayout.withController(
          controller: _controller,
          dismissOnTap: true,
          child: Container(),
        ),
        floatingActionButton: FloatingActionButton(
            child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, isLoading, _) =>
                  Icon(isLoading ? Icons.toggle_off : Icons.toggle_on),
            ),
            onPressed: () {
              _controller.value = !_controller.value;
            }),
      ),
    );
  }
}
```

## Changelog

[CHANGELOG](./CHANGELOG.md)

## License

[MIT License](./LICENSE)
