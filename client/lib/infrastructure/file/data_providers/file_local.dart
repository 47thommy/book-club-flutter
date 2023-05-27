import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:client/data/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class FileCache {
  final fileTable = DatabaseHelper.filetable;

  final _databaseHelper = DatabaseHelper.instance;
  late final Future<Database> database;

  FileCache() {
    database = _databaseHelper.database;
  }

  Future<Uint8List> _fileToByte(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    return uint8list;
  }

  Future<Uint8List> loadImage(String url) async {
    final db = await database;

    final List<Map<String, dynamic>> image =
        await db.query(fileTable, where: 'id = ?', whereArgs: [url]);

    if (image.isEmpty) {
      throw Exception('Image not found in cache');
    }

    return image[0]['data'] as Uint8List;
  }

  Future<void> saveImage(String url, Uint8List bytes) async {
    final db = await database;

    await db.insert(fileTable, {'id': url, 'data': bytes});
  }
}
