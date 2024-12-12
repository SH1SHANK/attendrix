import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'updated_tag_model.dart';
export 'updated_tag_model.dart';

class UpdatedTagWidget extends StatefulWidget {
  const UpdatedTagWidget({super.key});

  @override
  State<UpdatedTagWidget> createState() => _UpdatedTagWidgetState();
}

class _UpdatedTagWidgetState extends State<UpdatedTagWidget> {
  late UpdatedTagModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdatedTagModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4.0, 8.0, 4.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Updated',
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: const Color(0xFFFF6F00),
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
