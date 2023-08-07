import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';

class BaseDialog {
  static Future<void> showBaseDialog({
    required BuildContext context,
    required TypeOfVideoSettings typeOfVideoSettings,
  }) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Dialog.fullscreen(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: BodyVideoSettingsDialog(
                typeOfVideoSettings: typeOfVideoSettings,
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
