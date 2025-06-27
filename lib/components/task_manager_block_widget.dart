import '/backend/backend.dart';
import '/components/mime_image_icon_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'task_manager_block_model.dart';
export 'task_manager_block_model.dart';

class TaskManagerBlockWidget extends StatefulWidget {
  const TaskManagerBlockWidget({
    super.key,
    required this.materialReference,
  });

  final StudyMaterialsRecord? materialReference;

  @override
  State<TaskManagerBlockWidget> createState() => _TaskManagerBlockWidgetState();
}

class _TaskManagerBlockWidgetState extends State<TaskManagerBlockWidget> {
  late TaskManagerBlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaskManagerBlockModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              1.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.mimeImageIconModel,
                  updateCallback: () => safeSetState(() {}),
                  child: MimeImageIconWidget(
                    mimeType: valueOrDefault<String>(
                      widget.materialReference?.mimeType,
                      'unknown',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.materialReference?.fileName,
                          '{fileName}',
                        ),
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelLargeIsCustom,
                            ),
                      ),
                      if (widget.materialReference?.mimeType != 'folder')
                        Text(
                          '${widget.materialReference?.mimeType} | ${valueOrDefault<String>(
                            widget.materialReference?.fileSizeBytes
                                .toString(),
                            '0 KB',
                          )}',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: Icon(
                FFIcons.kdotsThreeOutlineVerticalBold,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
