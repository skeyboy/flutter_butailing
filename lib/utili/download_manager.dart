import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:path_provider/path_provider.dart';

class DownloadManager {
  static final DownloadManager _instance = DownloadManager._internal();
  factory DownloadManager() => _instance;
  DownloadManager._internal();

  final Dio _dio = Dio();
  final Map<String, CancelToken> _downloadTasks = {};

  /// 下载文件
  Future<DownloadResult> download({
    required String url,
    required String fileName,
    Function(int received, int total)? onProgress,
    Map<String, dynamic>? headers,
  }) async {
    final cancelToken = CancelToken();
    _downloadTasks[url] = cancelToken;

    try {
      final directory = await _getDownloadDirectory();
      String savePath = '${directory.path}/$fileName';
      logger.d('DownloadManager directory = $directory savePath = $savePath');
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
        options: Options(headers: headers),
      );

      _downloadTasks.remove(url);
      return DownloadResult.success(savePath);
    } on DioException catch (e) {
      _downloadTasks.remove(url);
      if (e.type == DioExceptionType.cancel) {
        return DownloadResult.cancelled();
      }
      return DownloadResult.error('下载失败: ${e.message}');
    } catch (e) {
      _downloadTasks.remove(url);
      return DownloadResult.error('下载失败: $e');
    }
  }

  /// 取消下载
  void cancelDownload(String url) {
    _downloadTasks[url]?.cancel();
    _downloadTasks.remove(url);
  }

  /// 获取所有正在下载的任务
  List<String> getDownloadingTasks() {
    return _downloadTasks.keys.toList();
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    } else {
      return Directory.current;
    }
  }
}

/// 下载结果封装
class DownloadResult {
  final bool success;
  final String? filePath;
  final String? error;
  final bool cancelled;

  DownloadResult._({
    required this.success,
    this.filePath,
    this.error,
    this.cancelled = false,
  });

  factory DownloadResult.success(String path) {
    return DownloadResult._(success: true, filePath: path);
  }

  factory DownloadResult.error(String error) {
    return DownloadResult._(success: false, error: error);
  }

  factory DownloadResult.cancelled() {
    return DownloadResult._(success: false, cancelled: true);
  }
}
