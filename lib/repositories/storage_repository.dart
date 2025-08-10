// lib/repositories/storage_repository.dart
import 'dart:io' show File;
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';

class StorageRepository {
  StorageRepository(this._storage);
  final FirebaseStorage _storage;

  static const _allowed = {'image/jpeg', 'image/png', 'image/webp'};

  // 파일 경로 기반(Mobile/Desktop)
  Future<String> uploadUserProfile({
    required String userId,
    required File file,
  }) async {
    final mime = lookupMimeType(file.path) ?? 'application/octet-stream';
    if (!_allowed.contains(mime)) {
      throw Exception('허용되지 않는 이미지 형식입니다. (jpg/png/webp)');
    }

    final ext = _extFromMime(mime);
    final ts = DateTime.now().millisecondsSinceEpoch;
    final ref = _storage.ref('users/$userId/profile_$ts$ext');

    await ref.putFile(file, SettableMetadata(contentType: mime));
    return await ref.getDownloadURL();
  }

  // 바이트 기반(Web 등)
  Future<String> uploadUserProfileBytes({
    required String userId,
    required Uint8List bytes,
    required String fileNameHint,
  }) async {
    final mime = lookupMimeType(fileNameHint, headerBytes: bytes) ?? 'application/octet-stream';
    if (!_allowed.contains(mime)) {
      throw Exception('허용되지 않는 이미지 형식입니다. (jpg/png/webp)');
    }

    final ext = _extFromMime(mime);
    final ts = DateTime.now().millisecondsSinceEpoch;
    final ref = _storage.ref('users/$userId/profile_$ts$ext');

    await ref.putData(bytes, SettableMetadata(contentType: mime));
    return await ref.getDownloadURL();
  }

  static String _extFromMime(String mime) {
    switch (mime) {
      case 'image/jpeg':
        return '.jpg';
      case 'image/png':
        return '.png';
      case 'image/webp':
        return '.webp';
      default:
        return '';
    }
  }
}
