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
