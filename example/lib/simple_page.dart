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
