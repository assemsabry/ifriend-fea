import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

/// A small singleton service that ensures only one permission request runs at a time.
class PermissionService {
  PermissionService._private();
  static final PermissionService instance = PermissionService._private();

  Completer<PermissionStatus>? _ongoing;

  /// Requests camera permission and ensures concurrent calls share the same request.
  Future<PermissionStatus> requestCameraPermission() async {
    // If there's an ongoing request, return its future to avoid concurrent prompts.
    if (_ongoing != null) return _ongoing!.future;

    _ongoing = Completer<PermissionStatus>();
    try {
      final status = await Permission.camera.status;
      if (status.isGranted) {
        _ongoing!.complete(status);
        return status;
      }

      final result = await Permission.camera.request();
      _ongoing!.complete(result);
      return result;
    } catch (_) {
      // On error complete with denied to be safe
      final denied = PermissionStatus.denied;
      if (!(_ongoing?.isCompleted ?? true)) {
        _ongoing!.complete(denied);
      }
      return denied;
    } finally {
      // allow next request in microtask to avoid races
      Future.microtask(() => _ongoing = null);
    }
  }
}
