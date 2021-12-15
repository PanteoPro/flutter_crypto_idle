import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    Key? key,
    required this.title,
    this.onTap,
    this.showBackIcon = true,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool showBackIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Stack(
          children: [
            if (showBackIcon)
              GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 40),
                Expanded(
                  child: Text(title, style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.center),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
