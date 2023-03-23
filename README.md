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
class HomePage extends StatefulWidget {

  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5))
        .then((value) =>
    {setState(() {
      isLoading = false;
    })});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // wrap your screen or widget with LoadWidget,
      // the widget will expand as large as possible, depending on its child's size.
      body: LoadingWidget(
          isLoading: isLoading, // or true
          // Optionally, you can define your custom indicator.
          // Otherwise the widget will show CircularProgressIndicator.
          indicator: YourCustomeIndicator(),
          child: YourPage()
      ),
    );
  }
}
```

* Use LoadingController

```dart
class HomePage extends StatelessWidget {

  final LoadingController _loadingController = LoadingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingWidget(
          // Register the controller.
          controller: _loadingController,
          child: YourPage(),
          ...
      ),
    );
  }
  
  toggleLoading(bool value){
    _loadingController.value = value;
  }
}
```

## Changelog

[CHANGELOG](./CHANGELOG.md)

## License

[MIT License](./LICENSE)
