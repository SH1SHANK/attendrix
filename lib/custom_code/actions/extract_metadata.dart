// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:io';
import 'package:mime/mime.dart';

Future<FileInfoStruct> extractMetadata(FFUploadedFile uploadedFile) async {
  try {
    return FileInfoStruct(
      name: uploadedFile.name ?? 'Unknown File',
      filePath: uploadedFile.bytes != null
          ? 'memory://${uploadedFile.name ?? 'file'}'
          : '',
      mimeType:
          lookupMimeType(uploadedFile.name ?? '') ?? 'application/octet-stream',
      sizeBytes: uploadedFile.bytes?.length ?? 0,
      createdAt: DateTime.now(),
      lastOpened: null,
      isLocalOnly: false,
      status: 'uploaded',
      message: 'File metadata extracted successfully',
    );
  } catch (e) {
    return FileInfoStruct(
      name: uploadedFile.name ?? 'Unknown File',
      filePath: '',
      mimeType: 'application/octet-stream',
      sizeBytes: 0,
      createdAt: DateTime.now(),
      lastOpened: null,
      isLocalOnly: false,
      status: 'error',
      message: 'Failed to extract metadata: ${e.toString()}',
    );
  }
}
