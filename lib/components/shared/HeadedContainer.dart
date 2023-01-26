import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class HeadedContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback callback;
  final Widget child;

  const HeadedContainer({
    Key? key,
    required this.title,
    required this.icon,
    required this.callback,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.backgroundGray,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Styles.mediumFont,
                ),
              ),
              ElevatedButton(onPressed: callback, child: Icon(icon))
            ],
          ),
          child,
        ],
      ),
    );
  }
}
