import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future uploadData() async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("http://192.168.173.163:3000/uploads"));

  print("<<<<<!!!");

  var image = await http.MultipartFile.fromPath(
    'image',
    (await getImageFileFromAssets("books.png")).path,
    filename: "image.png",
  );

  request.files.add(image);

  var res = await request.send();
  return res.statusCode;
}
