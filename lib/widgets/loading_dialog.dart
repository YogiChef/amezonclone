import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key, this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: Colors.green,
              // valueColor: AlwaysStoppedAnimation(Colors.pink),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '$message\nPlease wait...',
            textAlign: TextAlign.center,
            style: const TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}
