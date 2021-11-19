import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Stack(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
