import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning }

class TopLevelSnackBar {
  static void show(
    BuildContext context,
    String message, {
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    final OverlayState overlayState = Overlay.of(context);

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 10,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _getBackgroundColor(type),
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Icon(_getIcon(type), color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  onPressed: () => overlayEntry.remove(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    // 自动移除
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
    }
  }

  // 便捷方法
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(
      context,
      message,
      type: SnackBarType.success,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(
      context,
      message,
      type: SnackBarType.error,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(
      context,
      message,
      type: SnackBarType.warning,
      duration: duration ?? const Duration(seconds: 3),
    );
  }
}
