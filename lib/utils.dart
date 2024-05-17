import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:push_up_detection/models/push_up_model.dart';

Future<String> getAssetPath(String asset) async {
  final path = await getLocalPath(asset);
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}

Future<String> getLocalPath(String path) async {
  return '${(await getApplicationSupportDirectory()).path}/$path';
}

double angle(PoseLandmark firstLandmark, PoseLandmark midLandmark,PoseLandmark lastLandmark) {
  final radians =
      atan2(lastLandmark.y - midLandmark.y,
                lastLandmark.x - midLandmark.x) -
        atan2(firstLandmark.y - midLandmark.y,
                firstLandmark.x - midLandmark.x);
  double degrees = radians * 180.0 / pi;
  degrees = degrees.abs();
  if (degrees > 180.0) {
      degrees = 360.0 - degrees;
  }
  return degrees;
}

PushUpState? isPushUp(double angleElbow, PushUpState? current) {
  final tresholdElbow = 80.0;
  final tresholdElbowExtension = 160.0;

  if(current == PushUpState.neutral && angleElbow > tresholdElbowExtension && angleElbow < 180.0) {
    return PushUpState.init;
  } 
  else if (current == PushUpState.init && angleElbow < tresholdElbow && angleElbow > 40.0) {
    return PushUpState.complete;
  }
}