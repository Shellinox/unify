import 'package:flutter/material.dart';

showAlert(BuildContext context, String content, String title, String confirm,
    void Function()? onTap) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: onTap,
              child: Text(confirm),
            ),
          ],
        );
      });
}
