import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'mime_image_icon_model.dart';
export 'mime_image_icon_model.dart';

class MimeImageIconWidget extends StatefulWidget {
  const MimeImageIconWidget({
    super.key,
    String? mimeType,
  }) : this.mimeType = mimeType ?? 'unknown';

  final String mimeType;

  @override
  State<MimeImageIconWidget> createState() => _MimeImageIconWidgetState();
}

class _MimeImageIconWidgetState extends State<MimeImageIconWidget> {
  late MimeImageIconModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MimeImageIconModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (valueOrDefault<bool>(
          widget.mimeType == 'application/pdf',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/PDF_SVG_Vectors_and_Icons.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'application/vnd.ms-powerpoint',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Ppt_SVG_Vectors_and_Icons.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'text/plain',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/txt-file-symbol-svgrepo-com.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'text/csv',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/CSV_File_Format_Icon.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType ==
              'application/vnd.openxmlformats-officedocument.presentationml.presentation',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/PPTX_SVG_Icon.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'application/msword',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Doc_Monocolor_SVG.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType ==
              'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Docx_File_Format_Icon.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'image/png',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Png_SVG_Vectors_and_Icons.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'image/jpeg',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Jpg_SVG_Vectors_and_Icons.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'image/jpeg',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Jpeg_SVG_Vectors_and_Icons.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType ==
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Xlsx_SVG_Icons.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'application/vnd.ms-excel',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/XLS_SVG_Vectors_and_Icons.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else if (valueOrDefault<bool>(
          widget.mimeType == 'folder',
          false,
        )) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Folder_Outlined_Icon.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/File_Icon_from_SVG_Repo.svg',
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }
}
