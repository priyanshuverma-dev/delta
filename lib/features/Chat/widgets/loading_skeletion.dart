import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class LoadingSkeletion extends StatelessWidget {
  const LoadingSkeletion({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SkeletonLoader(
        builder: Card(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: size.width - 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: size.width - 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).highlightColor,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: size.width - 50,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: size.width - 100,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                   color: Theme.of(context).highlightColor,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: size.width - 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        items: 1,
        period: const Duration(seconds: 2),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
