import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tiger_newemployee/Constants/hide_keyboard.dart';
import 'package:tiger_newemployee/Constants/loading_screen.dart';
import 'package:tiger_newemployee/Models/image_saved.dart';

pickfile({
  context,
  String category = '',
}) async {
  hidekeyboard(context: context);
  FileUploadInputElement uploadInput = FileUploadInputElement();
  uploadInput.multiple = false;
  uploadInput.draggable = true;
  uploadInput.accept = 'image/*';
  uploadInput.click();

  uploadInput.onChange.listen((e) {
    final files = uploadInput.files;
    if (files != null) {
      final file = files[0];
      final reader = FileReader();
      reader.onLoadEnd.listen((e) {
        var _bytesData = const Base64Decoder()
            .convert(reader.result.toString().split(",").last);
        uploadFile(
            file: files[0],
            bytedata: _bytesData,
            context: context,
            category: category);
      });
      reader.readAsDataUrl(file);
    } else {
      debugPrint("No Files");
    }
  });

  uploadInput.remove();
}

String url = 'https://tigersecurity.in/hrdivisionapp/newformpics/uploadpic.php';
Future<ImageSave> uploadFile(
    {required File file,
    required List<int> bytedata,
    required context,
    required category}) async {
  showloading(context: context, titel: "Please Wait !!!");
  FormData data = FormData.fromMap({
    'file': MultipartFile.fromBytes(
      bytedata,
      filename: file.name,
    ),
    'category': category
  });
  Dio dio = Dio();
  var response = await dio.post(url, data: data);
  if (response.statusCode == 200) {
    var _body = response.data;
    Navigator.pop(context);
    return ImageSave.fromJson(_body);
  } else {
    Navigator.pop(context);
    return ImageSave(
      staus: 0,
      id: 0,
    );
  }
}
