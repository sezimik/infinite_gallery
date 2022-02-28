import 'package:flutter/material.dart';
import '../../config/config.dart';

class ImagePreview {
  void showFullsScreen(BuildContext context, String url) {
    showDialog(
      barrierColor: InfiniteColors.white.withAlpha(200),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: InfiniteColors.transparent,
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          content: Image.network(url),
          actions: <Widget>[
            TextButton(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.close,
                      color: InfiniteColors.darkGrey,
                    ),
                    Text(
                      kCloseTitle,
                      style: InfiniteTextStyles.title,
                    )
                  ]),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
