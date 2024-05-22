import 'package:flutter/material.dart';

class SearchBarUI extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  final bool isloading;

  const SearchBarUI({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.onPressed,
    required this.isloading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            width: .3,
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // Button
            IconButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
              ),
              icon: const Icon(Icons.send),
              onPressed: isloading ? null : onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
