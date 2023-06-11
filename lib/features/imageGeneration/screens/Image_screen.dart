import 'package:answer_it/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageGenScreen extends StatelessWidget {
  const ImageGenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.darkScaffoldColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Theme.of(context).secondaryHeaderColor,
          systemNavigationBarColor: Colours.textColor,
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topLeft,
                  colors: [
                    Colours.secondaryColor.withOpacity(0.5),
                    const Color.fromRGBO(115, 75, 109, 1),
                    Colors.white10,
                    const Color.fromRGBO(66, 39, 90, 1),
                    Colours.primaryColor.withOpacity(0.5),
                  ],
                ),
              ),
              child: RefreshIndicator(
                semanticsLabel: 'Refresh',
                color: Colours.textColor,
                strokeWidth: RefreshProgressIndicator.defaultStrokeWidth + 1,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                backgroundColor: Colours.darkScaffoldColor,
                onRefresh: () {
                  return Future.delayed(
                    const Duration(seconds: 1),
                    () {},
                  );
                },
                child: const Column(
                  children: [
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
